---
type: DuckDB Table
title: Olist Products Dataset
description: This dataset includes data about the products sold by Olist.
---

# 描述

原始商品表，一行一个商品。
- `product_category_name` 是葡语类目名，有的商品为空；英文类目需要 join `product_category_name_translation`。
- `product_weight_g`、`product_length_cm`、`product_height_cm`、`product_width_cm` 可能为空。
- 与订单商品关联用 `product_id`。

# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `product_id` | string | unique product identifier |
| `product_category_name` | string | root category of product, in Portuguese. |
| `product_name_lenght` | int32 | number of characters extracted from the product name. |
| `product_description_lenght` | int32 | number of characters extracted from the product description. |
| `product_photos_qty` | int32 | number of product published photos |
| `product_weight_g` | int32 | product weight measured in grams. |
| `product_length_cm` | int32 | product length measured in centimeters. |
| `product_height_cm` | int32 | product height measured in centimeters. |
| `product_width_cm` | int32 | product width measured in centimeters. |

# 数据采样

| product_id | product_category_name | product_name_lenght | product_description_lenght | product_photos_qty | product_weight_g | product_length_cm | product_height_cm | product_width_cm |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1e9e8ef04dbcff4541ed26657ea517e5 | perfumaria | 40 | 287 | 1 | 225 | 16 | 10 | 14 |
| 3aa071139cb16b67ca9e5dea641aaa2f | artes | 44 | 276 | 1 | 1000 | 30 | 18 | 20 |
| 96bd76ec8810374ed1b65e291975717f | esporte_lazer | 46 | 250 | 1 | 154 | 18 | 9 | 15 |
| cef67bcfe19066a932b7673e239eb23d | bebes | 27 | 261 | 1 | 371 | 26 | 4 | 26 |
| 9dc1a7de274444849c219cff195d0b71 | utilidades_domesticas | 37 | 402 | 4 | 625 | 20 | 17 | 13 |


# 关联关系

本表一行一个商品（`product_id`）。以下关系均从本表出发：

- [olist_order_items_dataset](table=olist_order_items_dataset.md)：本表 `product_id` → 对方 `product_id`。**一对多**：本表一行（商品）对应对方多行（订单商品）。
- [product_category_name_translation](table=product_category_name_translation.md)：本表 `product_category_name` → 对方 `product_category_name`。**多对一**：本表多行（多个商品）对应对方一行（一个类目）；本表类目可能为空。
