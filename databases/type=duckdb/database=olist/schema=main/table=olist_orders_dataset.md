---
type: DuckDB Table
title: Olist Orders Dataset
description: This is the core dataset. From each order you might find all other information.
---

# 描述

原始订单表，一行一个订单（`order_id` 唯一）。

- `order_purchase_timestamp` 是下单时间；`order_delivered_customer_date`、`order_estimated_delivery_date` 用于交付分析。
- `order_status`：delivered / shipped / canceled / unavailable / invoiced / processing / created / approved。
- `order_approved_at` 有很多行为空，`order_delivered_customer_date` 有很多行为空，交付计算要处理空值。
- 商品金额、运费、支付、评价都在各自的原始表里；先按 `order_id` 聚合明细（`olist_order_items_dataset`、`olist_order_payments_dataset`）或去重评价（`olist_order_reviews_dataset`），再与本表 join，避免金额重复计算。
- 时间范围 2016-09-04 至 2018-10-17；2018-09 之后数据明显不完整。

# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string | unique identifier of the order. |
| `customer_id` | string | key to the customer dataset. Each order has a unique customer_id. |
| `order_status` | string | Reference to the order status (delivered, shipped, etc). |
| `order_purchase_timestamp` | timestamp(6) | Shows the purchase timestamp. |
| `order_approved_at` | timestamp(6) | Shows the payment approval timestamp. |
| `order_delivered_carrier_date` | timestamp(6) | Shows the order posting timestamp. When it was handled to the logistic partner. |
| `order_delivered_customer_date` | timestamp(6) | Shows the actual order delivery date to the customer. |
| `order_estimated_delivery_date` | timestamp(6) | Shows the estimated delivery date that was informed to customer at the purchase moment. |

# 数据采样

| order_id | customer_id | order_status | order_purchase_timestamp | order_approved_at | order_delivered_carrier_date | order_delivered_customer_date | order_estimated_delivery_date |
| --- | --- | --- | --- | --- | --- | --- | --- |
| e481f51cbdc54678b7cc49136f2d6af7 | 9ef432eb6251297304e76186b10a928d | delivered | 2017-10-02 10:56:33 | 2017-10-02 11:07:15 | 2017-10-04 19:55:00 | 2017-10-10 21:25:13 | 2017-10-18 00:00:00 |
| 53cdb2fc8bc7dce0b6741e2150273451 | b0830fb4747a6c6d20dea0b8c802d7ef | delivered | 2018-07-24 20:41:37 | 2018-07-26 03:24:27 | 2018-07-26 14:31:00 | 2018-08-07 15:27:45 | 2018-08-13 00:00:00 |
| 47770eb9100c2d0c44946d9cf07ec65d | 41ce2a54c0b03bf3443c3d931a367089 | delivered | 2018-08-08 08:38:49 | 2018-08-08 08:55:23 | 2018-08-08 13:50:00 | 2018-08-17 18:06:29 | 2018-09-04 00:00:00 |
| 949d5b44dbf5de918fe9c16f97b45f8a | f88197465ea7920adcdbec7375364d82 | delivered | 2017-11-18 19:28:06 | 2017-11-18 19:45:59 | 2017-11-22 13:39:59 | 2017-12-02 00:28:42 | 2017-12-15 00:00:00 |
| ad21c59c0840e6cb83a9ceb5573f8159 | 8ab97904e6daea8866dbdbc4fb7aad2c | delivered | 2018-02-13 21:18:39 | 2018-02-13 22:20:29 | 2018-02-14 19:46:34 | 2018-02-16 18:17:02 | 2018-02-26 00:00:00 |


# 关联关系

- `olist_customers_dataset`：`customer_id` → `customer_id`（多对一，`customer_id` 是每单一个）
- `olist_order_items_dataset`：`order_id` → `order_id`（一对多，先聚合再 join）
- `olist_order_payments_dataset`：`order_id` → `order_id`（一对多，先聚合再 join）
- `olist_order_reviews_dataset`：`order_id` → `order_id`（一对多，先去重再 join）
