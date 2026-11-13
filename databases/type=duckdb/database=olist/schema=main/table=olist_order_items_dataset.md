---
type: DuckDB Table
title: Olist Order Items Dataset
description: This dataset includes data about the items purchased within each order.
---

# 描述

原始订单商品表，一行一个订单商品（`order_id + order_item_id`）。

- `price` 是商品单价，`freight_value` 是运费；订单金额 = 同一 `order_id` 下所有 `price + freight_value` 之和。
- 一个订单可能有多行商品；直接 join `olist_orders_dataset` 后再 `SUM(price)` 会把订单金额按行数放大，必须先聚合到 `order_id`。
- `product_id` 关联 `olist_products_dataset`，`seller_id` 关联 `olist_sellers_dataset`；可能有商品无法匹配到类目。

举例：

订单 order_id = 00143d0f86d6fbd9f9b38ab440ac16f5 包含 3 件商品（同一产品）。每件商品的运费根据其尺寸和重量分别计算。要得到每个订单的总运费，只需将各项相加即可。
订单商品总价值为：21.33 × 3 = 63.99
总运费为：15.10 × 3 = 45.30
订单总价值（商品 + 运费）为：45.30 + 63.99 = 109.29


# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string | order unique identifier |
| `order_item_id` | int32 | sequential number identifying number of items included in the same order. |
| `product_id` | string | product unique identifier |
| `seller_id` | string | seller unique identifier |
| `shipping_limit_date` | timestamp(6) | Shows the seller shipping limit date for handling the order over to the logistic partner. |
| `price` | decimal(12, 2) | item price |
| `freight_value` | decimal(12, 2) | item freight value item (if an order has more than one item the freight value is splitted between items) |

# 数据采样

| order_id | order_item_id | product_id | seller_id | shipping_limit_date | price | freight_value |
| --- | --- | --- | --- | --- | --- | --- |
| 00010242fe8c5a6d1ba2dd792cb16214 | 1 | 4244733e06e7ecb4970a6e2683c13e61 | 48436dade18ac8b2bce089ec2a041202 | 2017-09-19 09:45:35 | 58.90 | 13.29 |
| 00018f77f2f0320c557190d7a144bdd3 | 1 | e5f2d52b802189ee658865ca93d83a8f | dd7ddc04e1b6c2c614352b383efe2d36 | 2017-05-03 11:05:13 | 239.90 | 19.93 |
| 000229ec398224ef6ca0657da4fc703e | 1 | c777355d18b72b67abbeef9df44fd0fd | 5b51032eddd242adc84c38acab88f23d | 2018-01-18 14:48:30 | 199.00 | 17.87 |
| 00024acbcdf0a6daa1e931b038114c75 | 1 | 7634da152a4610f1595efa32f14722fc | 9d7a1d34a5052409006425275ba1c2b4 | 2018-08-15 10:10:18 | 12.99 | 12.79 |
| 00042b26cf59d7ce69dfabb4e55b4fd9 | 1 | ac6c3623068f30de03045865e4e10089 | df560393f3a51e74553ab94004ba5c87 | 2017-02-13 13:57:51 | 199.90 | 18.14 |

# 关联关系

本表一行一个订单商品（`order_id + order_item_id`）。以下关系均从本表出发：

- [olist_orders_dataset](table=olist_orders_dataset.md)：本表 `order_id` → 对方 `order_id`。**多对一**：本表多行（多个商品）对应对方一行（订单）。
- [olist_products_dataset](table=olist_products_dataset.md)：本表 `product_id` → 对方 `product_id`。**多对一**：本表多行对应对方一行（一个商品）。
- [olist_sellers_dataset](table=olist_sellers_dataset.md)：本表 `seller_id` → 对方 `seller_id`。**多对一**：本表多行对应对方一行（一个卖家）。
