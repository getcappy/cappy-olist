---
type: DuckDB Table
title: Fct Order Items
database: olist
schema: main
tags: []
---

# 描述

订单商品粒度事实表：一行一个订单商品（`order_id + order_item_id`，共 112,650 行）。金额单位为 BRL。

- `item_total = item_price + freight_value`；`item_price` 不含运费。
- 1,603 行商品无法匹配到类目（商品表缺类目或 `product_id` 不在商品表中），对应 `category_en = 'unknown'`，按类目汇总时建议单独说明。
- 订单级汇总请优先用 `fct_orders`；需要按商品、类目、卖家拆分时用本表。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 112,650 |
| **Column Count** | 15 |

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string |  |
| `order_item_id` | int32 |  |
| `product_id` | string |  |
| `seller_id` | string |  |
| `customer_unique_id` | string |  |
| `customer_state` | string |  |
| `purchase_ts` | timestamp(6) |  |
| `order_status` | string |  |
| `category_pt` | string |  |
| `category_en` | string |  |
| `seller_state` | string |  |
| `shipping_limit_ts` | timestamp(6) |  |
| `item_price` | decimal(12, 2) |  |
| `freight_value` | decimal(12, 2) |  |
| `item_total` | decimal(13, 2) |  |

# 数据采样

| order_id | order_item_id | product_id | seller_id | customer_unique_id | customer_state | purchase_ts | order_status | category_pt | category_en | seller_state | shipping_limit_ts | item_price | freight_value | item_total |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 00010242fe8c5a6d1ba2dd792cb16214 | 1 | 4244733e06e7ecb4970a6e2683c13e61 | 48436dade18ac8b2bce089ec2a041202 | 871766c5855e863f6eccc05f988b23cb | RJ | 2017-09-13 08:59:02 | delivered | cool_stuff | cool_stuff | SP | 2017-09-19 09:45:35 | 58.90 | 13.29 | 72.19 |
| 00018f77f2f0320c557190d7a144bdd3 | 1 | e5f2d52b802189ee658865ca93d83a8f | dd7ddc04e1b6c2c614352b383efe2d36 | eb28e67c4c0b83846050ddfb8a35d051 | SP | 2017-04-26 10:53:06 | delivered | pet_shop | pet_shop | SP | 2017-05-03 11:05:13 | 239.90 | 19.93 | 259.83 |
| 000229ec398224ef6ca0657da4fc703e | 1 | c777355d18b72b67abbeef9df44fd0fd | 5b51032eddd242adc84c38acab88f23d | 3818d81c6709e39d06b2738a8d3a2474 | MG | 2018-01-14 14:33:31 | delivered | moveis_decoracao | furniture_decor | MG | 2018-01-18 14:48:30 | 199.00 | 17.87 | 216.87 |
| 00024acbcdf0a6daa1e931b038114c75 | 1 | 7634da152a4610f1595efa32f14722fc | 9d7a1d34a5052409006425275ba1c2b4 | af861d436cfc08b2c2ddefd0ba074622 | SP | 2018-08-08 10:00:35 | delivered | perfumaria | perfumery | SP | 2018-08-15 10:10:18 | 12.99 | 12.79 | 25.78 |
| 00042b26cf59d7ce69dfabb4e55b4fd9 | 1 | ac6c3623068f30de03045865e4e10089 | df560393f3a51e74553ab94004ba5c87 | 64b576fb70d441e8f1b2d7d446e483c5 | SP | 2017-02-04 13:57:51 | delivered | ferramentas_jardim | garden_tools | PR | 2017-02-13 13:57:51 | 199.90 | 18.14 | 218.04 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T09:50:34.140201+00:00`

**Columns:** 15

## Column Profiles (JSONL)

- {"column": "order_id", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98666}
- {"column": "order_item_id", "type": "int32", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 21, "top_values": [{"value": 1, "count": 98666}, {"value": 2, "count": 9803}, {"value": 3, "count": 2287}, {"value": 4, "count": 965}, {"value": 5, "count": 460}, {"value": 6, "count": 256}, {"value": 7, "count": 58}, {"value": 8, "count": 36}, {"value": 9, "count": 28}, {"value": 10, "count": 25}]}
- {"column": "product_id", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 32951}
- {"column": "seller_id", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 3095}
- {"column": "customer_unique_id", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 95420}
- {"column": "customer_state", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27, "top_values": [{"value": "SP", "count": 47449}, {"value": "RJ", "count": 14579}, {"value": "MG", "count": 13129}, {"value": "RS", "count": 6235}, {"value": "PR", "count": 5740}, {"value": "SC", "count": 4176}, {"value": "BA", "count": 3799}, {"value": "DF", "count": 2406}, {"value": "GO", "count": 2333}, {"value": "ES", "count": 2256}]}
- {"column": "purchase_ts", "type": "timestamp(6)", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98112, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-09-03T09:06:57 00:00:00"}
- {"column": "order_status", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 7, "top_values": [{"value": "delivered", "count": 110197}, {"value": "shipped", "count": 1185}, {"value": "canceled", "count": 542}, {"value": "invoiced", "count": 359}, {"value": "processing", "count": 357}, {"value": "unavailable", "count": 7}, {"value": "approved", "count": 3}]}
- {"column": "category_pt", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 74}
- {"column": "category_en", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 74}
- {"column": "seller_state", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 23, "top_values": [{"value": "SP", "count": 80342}, {"value": "MG", "count": 8827}, {"value": "PR", "count": 8671}, {"value": "RJ", "count": 4818}, {"value": "SC", "count": 4075}, {"value": "RS", "count": 2199}, {"value": "DF", "count": 899}, {"value": "BA", "count": 643}, {"value": "GO", "count": 520}, {"value": "PE", "count": 448}]}
- {"column": "shipping_limit_ts", "type": "timestamp(6)", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 93318, "min": "2016-09-19T00:15:34 00:00:00", "max": "2020-04-09T22:35:08 00:00:00"}
- {"column": "item_price", "type": "decimal(12, 2)", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 5968, "min": "0.85", "max": "6735.00", "mean": 120.6537, "stddev": 183.6331}
- {"column": "freight_value", "type": "decimal(12, 2)", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 6999, "min": "0.00", "max": "409.68", "mean": 19.9903, "stddev": 15.8063}
- {"column": "item_total", "type": "decimal(13, 2)", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 25547, "min": "6.08", "max": "6929.31", "mean": 140.6441, "stddev": 190.7235}

# 关联关系

- `fct_orders`：`order_id` → `order_id`（多对一）
- `dim_products`：`product_id` → `product_id`（多对一）
- `dim_sellers`：`seller_id` → `seller_id`（多对一）
- `dim_customers`：`customer_unique_id` → `customer_unique_id`（多对一）
