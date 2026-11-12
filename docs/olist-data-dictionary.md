# Olist 数据集说明与口径字典

来源：[Kaggle — Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)，
数据由 Olist 于 2018 年公开，覆盖 2016-09 至 2018-10 的巴西电商交易。CSV 共 9 个文件、约 45 MB 压缩。
本项目把原始 CSV 原样落地为 `raw_*` 表，再由 dbt 构建 `stg_*` 和分析层 `fct_*` / `dim_*`，
所有业务指标通过 MetricFlow 语义层（`semantics/semantic_manifest.json`）统一口径。

## 1. 原始文件

| CSV | 行数 | 含义 | 本项目目标表 |
| --- | ---: | --- | --- |
| `olist_orders_dataset.csv` | 99,441 | 订单主表：状态与各环节时间戳 | `raw_orders` → `fct_orders` |
| `olist_customers_dataset.csv` | 99,441 | 订单对应的客户与地址 | `raw_customers` → `dim_customers` |
| `olist_order_items_dataset.csv` | 112,650 | 订单商品行：价格、运费、卖家 | `raw_order_items` → `fct_order_items` |
| `olist_order_payments_dataset.csv` | 103,886 | 支付流水：方式、分期、金额 | `raw_payments` → `fct_payments` |
| `olist_order_reviews_dataset.csv` | 99,224 | 评价：分数、评论、回复时间 | `raw_reviews` → `fct_reviews` |
| `olist_products_dataset.csv` | 32,951 | 商品：类目、重量尺寸、图片数 | `raw_products` → `dim_products` |
| `olist_sellers_dataset.csv` | 3,095 | 卖家与地址 | `raw_sellers` → `dim_sellers` |
| `product_category_name_translation.csv` | 71 | 葡语类目 → 英语类目 | `raw_category_translation` |
| `olist_geolocation_dataset.csv` | 1,000,163 | 邮编前缀的经纬度 | `raw_geolocation` → `dim_geolocation` |

## 2. 分析层字段

### fct_orders（订单粒度，99,441 行）

| 字段 | 类型 | 口径 |
| --- | --- | --- |
| `order_id` | string | 订单唯一键 |
| `customer_unique_id` | string | 客户唯一键（跨订单稳定） |
| `order_status` | string | delivered / shipped / canceled / unavailable / invoiced / processing / created / approved |
| `customer_state` | string | 客户所在州（两位缩写） |
| `purchase_ts` | timestamp | 下单时间 |
| `approved_ts` | timestamp | 支付批准时间（160 单为空） |
| `delivered_customer_ts` | timestamp | 送达客户时间（2,965 单为空） |
| `estimated_delivery_ts` | timestamp | 预计送达时间 |
| `item_count` | int | 商品行数 |
| `seller_count` | int | 涉及卖家数 |
| `merchandise_value` | decimal | 商品价格合计（不含运费） |
| `freight_value` | decimal | 运费合计 |
| `gmv` | decimal | `merchandise_value + freight_value` |
| `payment_value` | decimal | 支付流水合计 |
| `max_installments` | int | 最大分期数 |
| `review_score` | int | 最新评价分数（1-5，未评价为空） |
| `delivery_days` | int | 下单到送达的天数（仅已送达） |
| `is_late` | boolean | 已送达且晚于预计送达时间 |
| `is_delivered` | boolean | `order_status = 'delivered'` |
| `is_canceled` | boolean | `order_status = 'canceled'` |
| `has_items` | boolean | 是否有商品明细 |

### fct_order_items（订单商品粒度，112,650 行）

`order_id`、`order_item_id`、`product_id`、`seller_id`、`customer_unique_id`、`customer_state`、
`purchase_ts`、`order_status`、`category_pt`、`category_en`、`seller_state`、`shipping_limit_ts`、
`item_price`、`freight_value`、`item_total = item_price + freight_value`。

### fct_payments（支付流水粒度，103,886 行）

`order_id`、`payment_sequential`、`payment_type`、`installments`、`payment_value`、
`customer_unique_id`、`customer_state`、`purchase_ts`、`order_status`、`installment_band`。

### fct_reviews（订单评价粒度，98,673 行）

`review_id`、`order_id`、`review_score`、`review_comment_title`、`review_comment_message`、
`review_creation_ts`、`review_answer_ts`、`response_hours`、`customer_unique_id`、`customer_state`、
`purchase_ts`、`order_status`。每个订单保留 `review_answer_timestamp` 最新的一条评价。

### 维度表

- `dim_customers`（96,096 行）：`customer_unique_id`、`customer_state`、`customer_city`、`first_order_ts`、
  `last_order_ts`、`order_count`、`delivered_order_count`、`total_gmv`、`avg_review_score`、`is_repeat_customer`。
- `dim_products`（32,951 行）：`product_id`、`category_pt`、`category_en`、`name_length`、`description_length`、
  `photos_qty`、`weight_g`、`volume_cm3`、`first_seen_ts`、`weight_band`。
- `dim_sellers`（3,095 行）：`seller_id`、`seller_state`、`seller_city`、`zip_code_prefix`、`first_seen_ts`。
- `dim_geolocation`（19,015 行）：`zip_code_prefix`、`city`、`state`、`lat`、`lng`（按邮编取平均坐标）。

## 3. 指标定义

| 指标 | 公式 | 说明 |
| --- | --- | --- |
| `gmv` | `Σ(merchandise_value + freight_value)` | 成交总额，含运费 |
| `merchandise_value` | `Σ merchandise_value` | 商品收入，不含运费 |
| `freight_value` | `Σ freight_value` | 运费收入 |
| `orders` | `Σ 1` | 订单数（订单粒度） |
| `delivered_orders` | `Σ is_delivered` | 已送达订单数 |
| `canceled_orders` | `Σ is_canceled` | 已取消订单数 |
| `average_order_value` | `gmv / orders` | 客单价 |
| `late_orders` | `Σ is_late` | 延迟送达订单数 |
| `late_delivery_rate` | `late_orders / delivered_orders` | 延迟率 |
| `cancellation_rate` | `canceled_orders / orders` | 取消率 |
| `average_delivery_days` | `avg(delivery_days)` | 平均交付天数（已送达） |
| `items_sold` | `Σ 1`（商品行） | 销量 |
| `item_revenue` | `Σ item_price` | 商品行收入 |
| `average_item_price` | `item_revenue / items_sold` | 平均商品单价 |
| `customers` | `Σ 1`（客户维度） | 客户数 |
| `repeat_customers` | `Σ is_repeat_customer` | 复购客户数 |
| `repeat_customer_rate` | `repeat_customers / customers` | 复购率 |
| `average_customer_value` | `avg(total_gmv)` | 客户平均终身价值 |
| `payment_value` | `Σ payment_value` | 支付金额 |
| `average_payment_value` | `payment_value / payment_transactions` | 平均单笔支付 |
| `average_review_score` | `avg(review_score)` | 平均评分 |
| `low_reviews` | `Σ(review_score ≤ 2)` | 差评数 |
| `low_review_rate` | `low_reviews / reviews` | 差评率 |
| `catalog_products` | `Σ 1`（商品维度） | 在售商品数 |
| `sellers` | `Σ 1`（卖家维度） | 卖家数 |

## 4. 全量基线（2016-09-04 至 2018-10-17）

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

## 5. 复现步骤

```bash
# 1. 下载并解压 Kaggle 数据到 ../olist-data/raw
python scripts/load_olist.py

# 2. 构建 dbt 星型模型并生成 MetricFlow manifest
OLIST_DUCKDB_PATH=/Users/mry/Downloads/cappy-agent/olist-data/olist.duckdb \
  dbt run  --project-dir semantics/olist_dbt --profiles-dir semantics/olist_dbt
OLIST_DUCKDB_PATH=/Users/mry/Downloads/cappy-agent/olist-data/olist.duckdb \
  dbt parse --project-dir semantics/olist_dbt --profiles-dir semantics/olist_dbt
cp semantics/olist_dbt/target/semantic_manifest.json semantics/semantic_manifest.json

# 3. 重新生成表文档与指标文档
cappy sync
```

`semantics/olist_dbt/target/` 是 dbt 构建产物，不参与 Git 版本管理；提交的是
`semantics/semantic_manifest.json`（编译后的语义清单）。
