# Olist 巴西电商分析规则

本项目的分析对象是 **Olist Brazilian E-Commerce** 公开数据集：2016-09 至 2018-10 期间巴西 Olist
平台上约 10 万笔订单、9.6 万名客户、3 万件商品和 3 千家卖家的交易数据。

DuckDB 里**只有 9 张原始表**，表名和列名与 Kaggle CSV 完全一致，没有 `stg_*` / `fct_*` / `dim_*`
视图，也没有聚合、去重或派生列。所有指标由 agent 读取 OKF 指标定义后，直接用 `execute_sql`
在原始表上计算。

**回答业务问题的顺序：先读 `semantics/metrics/<metric>.md` 的 `# Computation`，再用
`execute_sql` 按原始表写 SQL。** 不要临场发明口径；本项目未启用 MetricFlow，`execute_semantic_query`
不可用。

## 一、9 张原始表

| 表 | 行数 | 粒度 | 关键列 | 用途 |
| --- | ---: | --- | --- | --- |
| `olist_orders_dataset` | 99,441 | 一行一个订单 | `order_id`、`customer_id`、`order_status`、各环节时间戳 | 订单数、状态、交付、时间维度 |
| `olist_customers_dataset` | 99,441 | 一行一个订单对应的客户 | `customer_id`、`customer_unique_id`、`customer_state` | 客户地域、客户唯一键 |
| `olist_order_items_dataset` | 112,650 | 一行一个订单商品 | `order_id`、`order_item_id`、`price`、`freight_value`、`product_id`、`seller_id` | GMV、销量、类目、卖家 |
| `olist_order_payments_dataset` | 103,886 | 一行一笔支付 | `order_id`、`payment_sequential`、`payment_type`、`payment_value` | 支付方式、分期、支付金额 |
| `olist_order_reviews_dataset` | 99,224 | 一行一条评价 | `order_id`、`review_score`、`review_creation_date` | 评分、差评 |
| `olist_products_dataset` | 32,951 | 一行一个商品 | `product_id`、`product_category_name`、重量尺寸 | 商品/类目属性 |
| `olist_sellers_dataset` | 3,095 | 一行一个卖家 | `seller_id`、`seller_state` | 卖家地域 |
| `product_category_name_translation` | 71 | 一行一个类目 | `product_category_name`、`product_category_name_english` | 葡语→英语类目 |
| `olist_geolocation_dataset` | 1,000,163 | 一行一条邮编坐标 | `geolocation_zip_code_prefix`、经纬度 | 地图/邮编参考 |

表文档在 `databases/type=duckdb/database=olist/schema=main/table=<表名>.md`，其中的 `# 表结构`、
`# 数据采样`、`# 数据剖析` 是 `cappy sync` 生成的；`# 描述` / `# 关联关系` 是手写的。

## 二、关联关系与去重

| 关系 | 关联键 | 基数 | 注意 |
| --- | --- | --- | --- |
| 订单 ↔ 客户 | `olist_orders_dataset.customer_id = olist_customers_dataset.customer_id` | 多对一 | `customer_id` 是每单一个，不是客户唯一键 |
| 订单 ↔ 商品 | `order_id` | 一对多 | 先把商品聚合到 `order_id` 再 join 订单 |
| 订单 ↔ 支付 | `order_id` | 一对多 | 先把支付聚合到 `order_id` |
| 订单 ↔ 评价 | `order_id` | 一对多 | 先按订单去重，保留最新评价 |
| 商品 ↔ 类目翻译 | `product_category_name` | 多对一 | 商品表类目可能为空 |
| 商品明细 ↔ 商品 | `product_id` | 多对一 | |
| 商品明细 ↔ 卖家 | `seller_id` | 多对一 | |
| 客户/卖家 ↔ 地理位置 | 邮编前缀 | 一对多 | 先按邮编聚合经纬度 |

**必须遵守的聚合规则：**

1. `olist_orders_dataset` 一行一单，可以直接 `COUNT(*)`、按 `order_id` 聚合。
2. `olist_order_items_dataset` 一行一个商品；要算订单金额，先
   `SUM(price + freight_value) GROUP BY order_id`，再 join 订单。直接 join 再求和会把订单金额按行数放大。
3. `olist_order_payments_dataset` 一行一笔支付；先 `SUM(payment_value) GROUP BY order_id`，再 join。
4. `olist_order_reviews_dataset` 同一订单可能多条评价；先按 `order_id` 去重（保留
   `review_answer_timestamp` 最新的一条），再算平均分/评价数。
5. 统计客户数必须用 `COUNT(DISTINCT customer_unique_id)`；`customer_id` 只是订单客户键。
6. 不要同时 join 两个一对多表（商品 + 支付）后再求和；先在各自子查询里聚合到 `order_id`。

## 三、OKF 语义模型

`semantics/` 是 OKF v0.2 知识包（markdown + YAML frontmatter）：

```text
semantics/
├── index.md                  # 入口：29 个指标 / 13 个维度
├── log.md                    # 变更记录
├── metrics/<metric>.md       # type: Metric
└── dimensions/<dimension>.md # type: Dimension
```

**指标文件**：`# Definition`（业务定义）、`# Computation`（官方 SQL，直接查原始表）、
`# Dimensions`（可切维度）、`# Notes`（基线、边界、坑）。文件里的 SQL 已经处理了聚合和去重，
可以改 `WHERE`、`GROUP BY`、时间范围，**不要改聚合公式**。

**维度文件**：`# SQL` 给出维度表达式，`# Available in` 列出可用的原始表，`# Notes` 说明 join 方式。

使用规则：

1. 先读 `semantics/index.md`，或用 `grep -r "营收" semantics/`、`ls semantics/metrics` 找指标文件。
2. 读 `# Computation`，用 `execute_sql` 执行；需要别的维度时按 `# Dimensions` 的链接查表达式。
3. 比率指标（客单价、延迟率、取消率、复购率、差评率）先分别聚合分子和分母，再相除，**不要对
   已算好的比率求平均**。
4. 回答时说明指标名、口径、时间范围和单位；小样本（复购、差评）带上样本量。

## 四、关键指标

| 业务问题 | 指标文件 | 核心口径 |
| --- | --- | --- |
| 总 GMV | `gmv.md` | `SUM(price + freight_value)`，先聚合到 `order_id`，无商品订单记 0 |
| 商品收入 / 运费 | `merchandise-value.md` / `freight-value.md` | `SUM(price)` / `SUM(freight_value)` |
| 订单数 / 已送达 / 已取消 | `orders.md` / `delivered-orders.md` / `canceled-orders.md` | 按 `order_status` 过滤 |
| 客单价 | `average-order-value.md` | GMV / 订单数，先聚合再相除 |
| 延迟订单 / 延迟率 | `late-orders.md` / `late-delivery-rate.md` | 已送达且 `order_delivered_customer_date > order_estimated_delivery_date` |
| 取消率 | `cancellation-rate.md` | `canceled / 全部订单` |
| 平均交付天数 | `average-delivery-days.md` | `DATE_DIFF('day', purchase, delivered)`，仅已送达 |
| 销量 / 商品收入 / 平均单价 | `items-sold.md` / `item-revenue.md` / `average-item-price.md` | 基于 `olist_order_items_dataset` |
| 客户数 / 复购客户 / 复购率 | `customers.md` / `repeat-customers.md` / `repeat-customer-rate.md` | `COUNT(DISTINCT customer_unique_id)`，订单数 >1 为复购 |
| 客户价值 / 人均订单数 | `average-customer-value.md` / `average-orders-per-customer.md` | 客户终身 GMV 平均值 / 订单总数 ÷ 客户数 |
| 支付金额 / 支付笔数 | `payment-value.md` / `payment-transactions.md` | 基于 `olist_order_payments_dataset` |
| 评分 / 差评率 | `average-review-score.md` / `low-review-rate.md` | 评价先去重，`review_score <= 2` 为差评 |
| 商品数 / 卖家数 | `catalog-products.md` / `sellers.md` | `COUNT(*)` |

口径要点：

- `gmv` 用商品价格 + 运费，不用支付金额。
- `average_order_value = gmv / orders`，任意切片下都先聚合再相除。
- `late_delivery_rate` 分母只含已送达订单。
- `cancellation_rate` 分母是全部订单。
- `repeat_customer_rate` 分母是全部 `customer_unique_id`。
- 支付金额与 GMV 口径不同（约 16.01M vs 15.84M），不要混用。
- 原始评价有重复，平均评分和评价数必须先按订单去重。

## 五、时间口径

- 数据范围：`2016-09-04` 至 `2018-10-17`（按 `order_purchase_timestamp`）。
- 2016 年 9-12 月订单极少；**2018-09 与 2018-10 数据明显不完整**（2018-09 仅 16 单、2018-10 仅 4 单），
  做月度趋势时默认截止到 **2018-08**，并在结论中说明。
- 订单时间用 `DATE_TRUNC('month', order_purchase_timestamp)`；客户 cohort 用每个客户的
  `MIN(order_purchase_timestamp)`；评价趋势用 `review_creation_date`。
- 时间戳为巴西当地时间，不做时区转换。

## 六、分析流程

1. **判断主题**：收入/订单、客户、商品/类目、卖家、支付、配送、评价。
2. **找指标定义**：读 `semantics/index.md` 或对应 `semantics/metrics/<metric>.md`，确认口径、单位和基线。
3. **写 SQL**：基于 `# Computation`，在 9 张原始表上用 `execute_sql` 查询；按 `# Dimensions` 的表达式切分。
4. **检查粒度**：商品/支付先聚合到 `order_id`，评价先按订单去重，客户用 `customer_unique_id`。
5. **回答**：给出指标口径、时间范围、Top N 排序依据；金额 2 位小数，比率用百分比，小样本带样本量。

## 七、已知数据坑

- `olist_customers_dataset` 一行一个 `customer_id`，不是一行一个客户；客户数用 `customer_unique_id`。
- `olist_order_reviews_dataset` 有 99,224 行，但只有 98,673 个订单有评价；同一订单可能多条评价。
- 775 个订单没有商品明细（多为 canceled / unavailable），其 GMV 记 0。
- 1,603 行商品无法匹配到类目，`category_en` 为 `unknown`；610 个商品本身没有类目。
- `payment_value` 与 GMV 不相等是正常的（分期、优惠券、拆分支付、未定义支付方式）。
- 地理位置表 100 万行、同一邮编多条坐标；做地图前先按邮编聚合，`city` / `state` 仅作参考。
- 交付字段只对已送达订单有值；延迟率分母不要用全部订单。
- 2018-09 之后数据截断，趋势分析默认截止 2018-08。
