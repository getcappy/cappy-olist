---
type: DuckDB Table
title: Product Category Name Translation
database: olist
schema: main
tags: []
---

# 描述

原始类目翻译表，一行一个类目（71 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**。

- `product_category_name`（葡语）→ `product_category_name_english`（英语）。
- 与 `olist_products_dataset.product_category_name` 关联后得到英文类目；没有翻译的类目保留葡语或记为 unknown。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 71 |
| **Column Count** | 2 |

| Column | Type | Description |
|--------|------|-------------|
| `product_category_name` | string |  |
| `product_category_name_english` | string |  |

# 数据采样

| product_category_name | product_category_name_english |
| --- | --- |
| beleza_saude | health_beauty |
| informatica_acessorios | computers_accessories |
| automotivo | auto |
| cama_mesa_banho | bed_bath_table |
| moveis_decoracao | furniture_decor |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.399647+00:00`

**Columns:** 2

## Column Profiles (JSONL)

- {"column": "product_category_name", "type": "string", "total_count": 71, "null_count": 0, "null_percentage": 0.0, "distinct_count": 71}
- {"column": "product_category_name_english", "type": "string", "total_count": 71, "null_count": 0, "null_percentage": 0.0, "distinct_count": 71}

# 关联关系

- `olist_products_dataset`：`product_category_name` → `product_category_name`（一对多）
