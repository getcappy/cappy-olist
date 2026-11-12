# Olist 巴西电商分析规则

本项目的分析对象是 **Olist Brazilian E-Commerce** 公开数据集：2016-09 至 2018-10 期间巴西 Olist
平台上约 10 万笔订单、9.6 万名客户、3 万件商品和 3 千家卖家的交易数据。数据仓库为 DuckDB，
星型模型用纯 SQL 构建（`sql/build_warehouse.sql`）；指标与维度以 **OKF（Open Knowledge Format
v0.2）** 的 markdown 概念文件定义在 `semantics/` 下。

回答业务问题时：**先读对应指标概念文件，再按 `# Computation` 的官方 SQL 口径用 `execute_sql`
计算**。不要临场发明指标口径；本项目未启用 dbt MetricFlow，`execute_semantic_query` 不可用。

## 一、数据架构

```text
9 个原始 CSV
  → raw_*        （原样落地，不要直接用于业务分析）
  → stg_*        （重命名、去重、类型规范）
  → fct_* / dim_*（对外分析层，所有指标基于这一层）
```

- 原始表：`raw_orders`、`raw_customers`、`raw_order_items`、`raw_payments`、`raw_reviews`、
  `raw_products`、`raw_sellers`、`raw_category_translation`、`raw_geolocation`。
- 分析层表：`fct_orders`（订单粒度）、`fct_order_items`（订单商品粒度）、`fct_payments`（支付流水粒度）、
  `fct_reviews`（订单评价粒度）、`dim_customers`（客户粒度）、`dim_products`、`dim_sellers`、
  `dim_geolocation`（邮编粒度）。
- 除非问题明确要求排查原始数据，否则**只用 `fct_*` 和 `dim_*`**。每张表的粒度、坑和关联关系见
  `databases/type=duckdb/database=olist/schema=main/table=<表名>.md` 的 `# 描述` / `# 关联关系`。

## 二、核心数据模型与关联

| 表 | 粒度 | 主键 / 关键字段 | 用途 |
| --- | --- | --- | --- |
| `fct_orders` | 一行一个订单 | `order_id`，`customer_unique_id` | GMV、订单数、客单价、取消率、延迟率、交付时长、评分 |
| `fct_order_items` | 一行一个订单商品 | `order_id + order_item_id` | 销量、类目/卖家/商品维度、单价与运费 |
| `fct_payments` | 一行一笔支付 | `order_id + payment_sequential` | 支付方式、分期、支付金额 |
| `fct_reviews` | 一行一个订单（最新评价） | `order_id` | 评分分布、差评率、回复时长 |
| `dim_customers` | 一行一个客户 | `customer_unique_id` | 客户数、复购、客户价值 |
| `dim_products` | 一行一个商品 | `product_id` | 类目、重量、首次售出时间 |
| `dim_sellers` | 一行一个卖家 | `seller_id` | 卖家州、首次售出时间 |
| `dim_geolocation` | 一行一个邮编前缀 | `zip_code_prefix` | 地图与区域分析 |

关联键：

- 订单 ↔ 客户：`fct_orders.customer_unique_id = dim_customers.customer_unique_id`
- 订单 ↔ 商品明细：`fct_orders.order_id = fct_order_items.order_id`
- 订单 ↔ 支付：`fct_orders.order_id = fct_payments.order_id`
- 订单 ↔ 评价：`fct_orders.order_id = fct_reviews.order_id`
- 商品明细 ↔ 商品：`fct_order_items.product_id = dim_products.product_id`
- 商品明细 ↔ 卖家：`fct_order_items.seller_id = dim_sellers.seller_id`
- 邮编：`dim_geolocation.zip_code_prefix` 关联客户/卖家邮编前缀

**防重复计数**：`fct_orders` 已是订单粒度，直接聚合即可；如果先 join `fct_order_items` 或
`fct_payments` 再 `sum(gmv)`，会把订单金额按明细行数放大。需要商品/支付维度时，用对应的
`fct_order_items` / `fct_payments` 指标，或先在子查询里聚合到 `order_id` 再 join。

## 三、语义模型（OKF）

`semantics/` 是一个 OKF v0.2 知识包（markdown + YAML frontmatter，无外部 SDK）：

```text
semantics/
├── index.md                  # 入口：29 个指标 / 13 个维度，按主题分组
├── log.md                    # 变更记录
├── metrics/<metric>.md       # type: Metric
└── dimensions/<dimension>.md # type: Dimension
```

**指标文件**结构（每个文件一个概念）：

```yaml
---
type: Metric
title: "GMV"
description: "Gross merchandise value: item prices plus freight, in BRL."
tags: [revenue, orders]
aliases: ["revenue", "营收", "销售额"]
unit: BRL
status: stable
sources: [...]
---
# Definition     业务定义
# Computation    官方 SQL 口径
# Dimensions     可切分的维度（链接到 dimensions/*.md）
# Notes          基线值、边界、常见坑
# Related metrics 相关指标
```

**维度文件**包含 `# Definition`、`# SQL`（维度表达式）、`# Available in`（哪些表有这一列）和 `# Notes`。

使用规则：

1. 先读 `semantics/index.md`，或用 `grep -r "营收" semantics/`、`ls semantics/metrics` 找到指标文件；
   文件名即指标名（如 `gmv.md`、`average-order-value.md`）。
2. 读该文件的 `# Computation`，用 `execute_sql` 执行。可以改 `WHERE`、`GROUP BY`、时间范围，
   **不要改聚合公式**（分子分母的定义）。
3. 比率指标（客单价、延迟率、取消率、复购率、差评率）先聚合分子分母、再相除，**不要对已算好的
   比率求平均**。
4. 回答时说明指标名、口径、时间范围和单位；复购/差评等小样本指标要带上样本量。
5. 语义层之外的问题（城市排名、评论文本、地理分布等）直接基于 `fct_*` / `dim_*` 写 SQL。

## 四、关键指标与文件

| 业务问题 | 指标文件 | 常用维度 |
| --- | --- | --- |
| 总 GMV / 商品收入 / 运费 | `gmv.md` / `merchandise-value.md` / `freight-value.md` | `date`、`customer-state` |
| 订单数 / 已送达 / 已取消 | `orders.md` / `delivered-orders.md` / `canceled-orders.md` | `date`、`order-status`、`customer-state` |
| 客单价 | `average-order-value.md` | `date`、`customer-state`、`order-status` |
| 取消率 / 延迟率 | `cancellation-rate.md` / `late-delivery-rate.md` | `date`、`customer-state` |
| 平均交付时长 | `average-delivery-days.md` | `date`、`customer-state` |
| 销量 / 商品收入 / 平均单价 | `items-sold.md` / `item-revenue.md` / `average-item-price.md` | `category`、`seller-state`、`customer-state` |
| 客户数 / 复购客户 / 复购率 | `customers.md` / `repeat-customers.md` / `repeat-customer-rate.md` | `customer-first-order-date`、`customer-state`、`customer-type` |
| 客户价值 / 人均订单数 | `average-customer-value.md` / `average-orders-per-customer.md` | `customer-first-order-date`、`customer-type` |
| 支付金额 / 支付笔数 / 平均支付 | `payment-value.md` / `payment-transactions.md` / `average-payment-value.md` | `payment-type`、`installment-band` |
| 评分 / 差评率 | `average-review-score.md` / `low-reviews.md` / `low-review-rate.md` | `review-score`、`review-date`、`order-status` |
| 商品数 / 卖家数 | `catalog-products.md` / `sellers.md` | `category`、`weight-band`、`seller-state` |

指标口径要点：

- `gmv = merchandise_value + freight_value`（商品价格 + 运费），不是支付金额。
- `average_order_value = gmv / orders`，在任意切片下都先聚合再相除。
- `late_delivery_rate = late_orders / delivered_orders`，分母只含已送达订单。
- `cancellation_rate = canceled_orders / orders`，分母是全部订单。
- `repeat_customer_rate = repeat_customers / customers`，客户按 `customer_unique_id` 去重。
- `average_review_score` 只统计有评价的订单，空评分不计入。
- 支付金额与 GMV 口径不同：全量支付合计约 16.01M，GMV 约 15.84M，差异来自分期/优惠/拆分支付；
  回答"收入"时默认用 `gmv`，并说明口径。

## 五、时间口径

- 数据范围：`2016-09-04` 至 `2018-10-17`（按 `purchase_ts`）。
- 2016 年 9-12 月订单极少；**2018-09 与 2018-10 数据明显不完整**（2018-09 仅 16 单、2018-10 仅 4 单），
  做月度趋势时默认截止到 **2018-08**，并在结论中说明。
- 订单类指标用 `DATE_TRUNC('month', purchase_ts)`；客户 cohort 用 `first_order_ts`；评价趋势用
  `review_creation_ts`。
- 时间戳为巴西当地时间，不做时区转换。

## 六、分析流程

1. **判断主题**：收入/订单、客户、商品/类目、卖家、支付、配送、评价。
2. **找指标定义**：读 `semantics/index.md` 或对应 `semantics/metrics/<metric>.md`，确认口径、单位和基线。
3. **写 SQL**：基于 `# Computation`，用 `execute_sql` 查询；维度按 `# Dimensions` 的链接查表达式。
4. **检查粒度**：确认没有把订单表和明细表混在一起造成重复计数。
5. **回答**：给出指标口径、时间范围、Top N 排序依据；金额 2 位小数，比率用百分比，小样本带样本量。

## 七、已知数据坑

- `raw_customers.customer_id` 是"每笔订单一个"的键，**统计客户必须用 `customer_unique_id`**。
- 原始评价表一个订单可能有多条评价，`fct_reviews` 只保留最新一条；不要直接对 `raw_reviews` 求平均。
- 775 个订单没有商品明细（多为 canceled / unavailable），其 `gmv = 0`；按订单算客单价时是否剔除要说明。
- 1,603 行商品缺类目，`category_en = 'unknown'`；按类目排名时可将 unknown 单列或排除。
- `payment_value` 与 `gmv` 不相等是正常的（分期、优惠券、拆分支付、未定义支付方式）。
- 地理位置原始表有 100 万行、同一邮编多条坐标，`dim_geolocation` 已按邮编聚合为平均经纬度。
- 交付相关字段（`delivered_customer_ts`、`delivery_days`、`is_late`）只对已送达订单有值，
  计算延迟率时不要用全部订单做分母。
