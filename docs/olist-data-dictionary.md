# Olist 数据集说明与口径字典

来源：[Kaggle — Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)，
数据由 Olist 于 2018 年公开，覆盖 2016-09 至 2018-10 的巴西电商交易。

本项目**不做数据处理**：9 个 CSV 原样导入 DuckDB，表名和列名与 CSV 完全一致；没有视图、聚合、
去重或派生列。指标以 OKF v0.2 markdown 概念文件定义在 `semantics/`，由 cappy agent 读取后
用 `execute_sql` 在原始表上计算。

## 1. 原始文件 → DuckDB 表

| CSV | 行数 | DuckDB 表 |
| --- | ---: | --- |
| `olist_orders_dataset.csv` | 99,441 | `olist_orders_dataset` |
| `olist_customers_dataset.csv` | 99,441 | `olist_customers_dataset` |
| `olist_order_items_dataset.csv` | 112,650 | `olist_order_items_dataset` |
| `olist_order_payments_dataset.csv` | 103,886 | `olist_order_payments_dataset` |
| `olist_order_reviews_dataset.csv` | 99,224 | `olist_order_reviews_dataset` |
| `olist_products_dataset.csv` | 32,951 | `olist_products_dataset` |
| `olist_sellers_dataset.csv` | 3,095 | `olist_sellers_dataset` |
| `product_category_name_translation.csv` | 71 | `product_category_name_translation` |
| `olist_geolocation_dataset.csv` | 1,000,163 | `olist_geolocation_dataset` |

本地数据目录：

```text
olist-data/
├── source/brazilian-ecommerce-kaggle.zip   # Kaggle 原始压缩包
├── raw/*.csv                               # 9 个原始 CSV
├── SHA256SUMS                              # 压缩包 + CSV 校验和
└── olist.duckdb                            # 只有 9 张原始表
```

## 2. 表结构与粒度

### olist_orders_dataset（99,441 行，一行一单）

`order_id`、`customer_id`、`order_status`、`order_purchase_timestamp`、`order_approved_at`、
`order_delivered_carrier_date`、`order_delivered_customer_date`、`order_estimated_delivery_date`。

- `order_status`：delivered / shipped / canceled / unavailable / invoiced / processing / created / approved。
- `order_approved_at` 160 行为空，`order_delivered_customer_date` 2,965 行为空。

### olist_customers_dataset（99,441 行，一行一个订单客户）

`customer_id`、`customer_unique_id`、`customer_zip_code_prefix`、`customer_city`、`customer_state`。

- `customer_id` 是每单一个的键；客户唯一键是 `customer_unique_id`（96,096 个）。

### olist_order_items_dataset（112,650 行，一行一个订单商品）

`order_id`、`order_item_id`、`product_id`、`seller_id`、`shipping_limit_date`、`price`、`freight_value`。

- 订单金额 = 同一 `order_id` 下 `SUM(price + freight_value)`。
- 1,603 行商品无法匹配到类目。

### olist_order_payments_dataset（103,886 行，一行一笔支付）

`order_id`、`payment_sequential`、`payment_type`、`payment_installments`、`payment_value`。

- 一个订单可能有多笔支付；按订单汇总前先 `SUM(payment_value) GROUP BY order_id`。

### olist_order_reviews_dataset（99,224 行，一行一条评价）

`review_id`、`order_id`、`review_score`、`review_comment_title`、`review_comment_message`、
`review_creation_date`、`review_answer_timestamp`。

- 同一 `order_id` 可能有多条评价；计算评分前按订单去重，保留 `review_answer_timestamp` 最新的一条。
- 去重后 98,673 个订单有评价；768 个订单没有评价。

### olist_products_dataset（32,951 行，一行一个商品）

`product_id`、`product_category_name`、`product_name_lenght`、`product_description_lenght`、
`product_photos_qty`、`product_weight_g`、`product_length_cm`、`product_height_cm`、`product_width_cm`。

- 列名保留源文件拼写（`lenght`）。
- 610 个商品没有类目。

### olist_sellers_dataset（3,095 行，一行一个卖家）

`seller_id`、`seller_zip_code_prefix`、`seller_city`、`seller_state`。

### product_category_name_translation（71 行，一行一个类目）

`product_category_name`、`product_category_name_english`。

### olist_geolocation_dataset（1,000,163 行，一行一条邮编坐标）

`geolocation_zip_code_prefix`、`geolocation_lat`、`geolocation_lng`、`geolocation_city`、`geolocation_state`。

- 同一邮编有多条记录；地图分析前先按邮编聚合经纬度，城市/州仅作标签参考。

## 3. 关联与去重

| 关系 | 关联键 | 基数 | 注意 |
| --- | --- | --- | --- |
| 订单 ↔ 客户 | `customer_id` | 多对一 | 客户唯一键用 `customer_unique_id` |
| 订单 ↔ 商品 | `order_id` | 一对多 | 先聚合到 `order_id` |
| 订单 ↔ 支付 | `order_id` | 一对多 | 先聚合到 `order_id` |
| 订单 ↔ 评价 | `order_id` | 一对多 | 先按订单去重 |
| 商品明细 ↔ 商品 | `product_id` | 多对一 | |
| 商品明细 ↔ 卖家 | `seller_id` | 多对一 | |
| 商品 ↔ 类目翻译 | `product_category_name` | 多对一 | |
| 客户/卖家 ↔ 地理 | 邮编前缀 | 一对多 | 先按邮编聚合 |

核心规则：

1. 商品和支付表先各自聚合到 `order_id`，再 join 订单。
2. 评价先按 `order_id` 去重，再算平均分/评价数。
3. 客户数用 `COUNT(DISTINCT customer_unique_id)`。
4. 不要同时 join 商品和支付两个一对多表后求和。

## 4. 指标公式

| 指标 | 原始表口径 |
| --- | --- |
| `gmv` | `SUM(price + freight_value)`，先按 `order_id` 聚合；无商品订单为 0 |
| `merchandise_value` | `SUM(price)` |
| `freight_value` | `SUM(freight_value)` |
| `orders` | `COUNT(*)` on orders |
| `delivered_orders` | `COUNT(*) WHERE order_status = 'delivered'` |
| `canceled_orders` | `COUNT(*) WHERE order_status = 'canceled'` |
| `average_order_value` | `gmv / orders`，先聚合再相除 |
| `late_orders` | 已送达且 `order_delivered_customer_date > order_estimated_delivery_date` |
| `late_delivery_rate` | `late_orders / delivered_orders` |
| `cancellation_rate` | `canceled_orders / orders` |
| `average_delivery_days` | `AVG(DATE_DIFF('day', purchase, delivered))`，仅已送达 |
| `items_sold` | `COUNT(*)` on order items |
| `item_revenue` | `SUM(price)` on order items |
| `item_freight` | `SUM(freight_value)` on order items |
| `average_item_price` | `item_revenue / items_sold` |
| `customers` | `COUNT(DISTINCT customer_unique_id)` |
| `repeat_customers` | 订单数 > 1 的 `customer_unique_id` 数 |
| `repeat_customer_rate` | `repeat_customers / customers` |
| `average_customer_value` | 每个客户终身 GMV 的平均值 |
| `average_orders_per_customer` | 订单总数 / 客户数 |
| `payment_value` | `SUM(payment_value)` |
| `payment_transactions` | `COUNT(*)` on payments |
| `average_payment_value` | `payment_value / payment_transactions` |
| `average_review_score` | 去重后 `AVG(review_score)` |
| `reviews` | 去重后评价数 |
| `low_reviews` | 去重后 `review_score <= 2` 的数量 |
| `low_review_rate` | `low_reviews / reviews` |
| `catalog_products` | `COUNT(*)` on products |
| `sellers` | `COUNT(*)` on sellers |

每个指标的完整 SQL 见 `semantics/metrics/<metric>.md` 的 `# Computation`。

## 5. 全量基线（2016-09-04 至 2018-10-17）

| 指标 | 值 |
| --- | ---: |
| GMV | 15,843,553.24 |
| 商品收入 | 13,591,643.70 |
| 运费 | 2,251,909.54 |
| 订单数 | 99,441 |
| 已送达订单 | 96,478 |
| 取消订单 | 625 |
| 客单价（AOV） | 159.33 |
| 平均评分 | 4.086 |
| 平均交付天数 | 12.50 |
| 延迟率 | 8.11% |
| 取消率 | 0.63% |
| 客户数 | 96,096 |
| 复购客户 | 2,997（3.12%） |
| 客户平均终身价值 | 164.87 |
| 商品销量 | 112,650 |
| 支付金额 | 16,008,872.12 |

> 复购率低是该数据集的真实特征（Olist 平台以一次性购买为主），不是查询错误。

## 6. 语义模型与复现

`semantics/` 是 OKF v0.2 知识包：

```text
semantics/index.md              29 个指标 / 13 个维度，入口
semantics/metrics/<metric>.md   每个指标一个概念：Definition / Computation / Dimensions / Notes
semantics/dimensions/<dim>.md   维度表达式与可用表
semantics/log.md                变更记录
```

复现：

```bash
# 1. 下载并解压 Kaggle 数据到 ../olist-data/raw
python scripts/load_olist.py

# 2. 校验 OKF 知识包（frontmatter 与内部链接）
python scripts/validate_okf.py

# 3. 重新生成 cappy 表文档
cappy sync
```

不需要 dbt、MetricFlow、`semantic_manifest.json` 或任何视图；`semantics/` 下只有 markdown 概念文件。
