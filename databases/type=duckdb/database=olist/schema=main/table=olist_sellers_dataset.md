---
type: DuckDB Table
title: Olist Sellers Dataset
description: This dataset includes data about the sellers that fulfilled orders made at Olist.
---

# 描述

该数据集包含在 Olist 平台上完成订单履约的卖家（seller）信息。可以用它来查找卖家的所在地，并识别每个商品是由哪个卖家履约（发货）的。

原始卖家表，一行一个卖家。

- `seller_state` / `seller_city` 是卖家所在地。
- 与订单商品关联用 `olist_order_items_dataset.seller_id = olist_sellers_dataset.seller_id`。

# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `seller_id` | string | seller unique identifier |
| `seller_zip_code_prefix` | string | first 5 digits of seller zip code |
| `seller_city` | string | seller city name |
| `seller_state` | string | seller state |

# 数据采样

| seller_id | seller_zip_code_prefix | seller_city | seller_state |
| --- | --- | --- | --- |
| 3442f8959a84dea7ee197c632cb2df15 | 13023 | campinas | SP |
| d1b65fc7debc3361ea86b5f14c68d2e2 | 13844 | mogi guacu | SP |
| ce3ad9de960102d0677a81f5d0bb7b2d | 20031 | rio de janeiro | RJ |
| c0f3eea2e14555b6faeea3dd58c1b1c3 | 04195 | sao paulo | SP |
| 51a04a8a6bdcb23deccc82b0b80742cf | 12914 | braganca paulista | SP |

# 关联关系

本表一行一个卖家（`seller_id`）。以下关系均从本表出发：

- [olist_order_items_dataset](table=olist_order_items_dataset.md)：本表 `seller_id` → 对方 `seller_id`。**一对多**：本表一行（卖家）对应对方多行（订单商品）。
- [olist_geolocation_dataset](table=olist_geolocation_dataset.md)：本表 `seller_zip_code_prefix` → 对方 `geolocation_zip_code_prefix`。**多对多**：本表多行 ↔ 对方多行（同一邮编多条坐标）；先把对方按邮编聚合。
