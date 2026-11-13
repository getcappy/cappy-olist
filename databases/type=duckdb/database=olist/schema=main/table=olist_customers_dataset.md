---
type: DuckDB Table
title: Olist Customers Dataset
description: 该数据集包含客户及其位置的信息。请用它来识别订单数据集中的唯一客户，并找出订单的配送地点。
---

# 描述

该数据集包含客户及其位置的信息。请用它来识别订单数据集中的唯一客户，并找出订单的配送地点。每个订单都会分配到一个唯一的 customer_id。这意味着，同一客户的不同订单会获得不同的 customer_id。数据集中设置 customer_unique_id 的目的，是让你能够识别曾在店铺中重复购买的客户。否则，你会发现每个订单都对应着不同的客户，就好像每个客户只下过一单。

- `customer_id` 是"每笔订单一个"的键，**不是客户唯一键**；统计客户必须用 `customer_unique_id`。
- `customer_state` / `customer_city` 是订单收货地址的州/城市，可直接用于地域分析。
- 要与订单关联时用 `customer_id`；客户级聚合要先按 `customer_unique_id` 去重/汇总。

# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `customer_id` | string | key to the orders dataset. Each order has a unique customer_id. |
| `customer_unique_id` | string | unique identifier of a customer. |
| `customer_zip_code_prefix` | string | first five digits of customer zip code |
| `customer_city` | string | customer city name  |
| `customer_state` | string | customer state |

# 数据采样

| customer_id | customer_unique_id | customer_zip_code_prefix | customer_city | customer_state |
| --- | --- | --- | --- | --- |
| 06b8999e2fba1a1fbc88172c00ba8bc7 | 861eff4711a542e4b93843c6dd7febb0 | 14409 | franca | SP |
| 18955e83d337fd6b2def6b18a428ac77 | 290c77bc529b7ac935b93aa66c333dc3 | 09790 | sao bernardo do campo | SP |
| 4e7b3e00288586ebd08712fdd0374a03 | 060e732b5b29e8181a18229c7b0b2b5e | 01151 | sao paulo | SP |
| b2b6027bc5c5109e529d4dc6358b12c3 | 259dac757896d24d7702b9acbbff3f3c | 08775 | mogi das cruzes | SP |
| 4f2d8ab171c80ec8364f7c12e35b23ad | 345ecd01c38d18a9036ed96c73b8d066 | 13056 | campinas | SP |

# 关联关系

本表一行一条订单客户记录（`customer_id`）。以下关系均从本表出发：

- [olist_orders_dataset](table=olist_orders_dataset.md)：本表 `customer_id` → 对方 `customer_id`。**一对一**：每个 `customer_id` 只对应一个订单；按 `customer_unique_id` 看，一个客户可对应多个订单。
- [olist_geolocation_dataset](table=olist_geolocation_dataset.md)：本表 `customer_zip_code_prefix` → 对方 `geolocation_zip_code_prefix`。**多对多**：本表多行（多个客户）↔ 对方多行（同一邮编多条坐标）；先把对方按邮编聚合。
