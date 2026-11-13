---
type: DuckDB Table
title: Product Category Name Translation
description: Translates the product_category_name to english.
---

# 描述

原始类目翻译表，一行一个类目。

- `product_category_name`（葡语）→ `product_category_name_english`（英语）。
- 与 `olist_products_dataset.product_category_name` 关联后得到英文类目；没有翻译的类目保留葡语或记为 unknown。

# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `product_category_name` | string | category name in Portuguese |
| `product_category_name_english` | string | category name in English |

# 数据采样

| product_category_name | product_category_name_english |
| --- | --- |
| beleza_saude | health_beauty |
| informatica_acessorios | computers_accessories |
| automotivo | auto |
| cama_mesa_banho | bed_bath_table |
| moveis_decoracao | furniture_decor |


# 关联关系

本表一行一个类目（`product_category_name`）。以下关系均从本表出发：

- [olist_products_dataset](table=olist_products_dataset.md)：本表 `product_category_name` → 对方 `product_category_name`。**一对多**：本表一行（类目）对应对方多行（多个商品）。
