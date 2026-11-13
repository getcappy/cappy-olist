---
type: DuckDB Table
title: Olist Geolocation Dataset
description: 该数据集包含巴西邮政编码（zip codes）及其经纬度坐标信息。请利用它绘制地图，并计算卖家与客户之间的距离。
---

# 描述

该数据集包含巴西邮政编码（zip codes）及其经纬度坐标信息。请利用它绘制地图，并计算卖家与客户之间的距离。原始地理位置表，一行一条邮编坐标记录。

- 同一个 `geolocation_zip_code_prefix` 有多条记录，经纬度、城市名、州名可能不一致；同一邮编可能有 5 种城市拼写，个别邮编跨 2 个州。
- 做地图分析前先按邮编聚合：`AVG(geolocation_lat)`、`AVG(geolocation_lng)`；城市/州可 `ANY_VALUE` 或取众数，仅作标签参考。
- 邮编前缀可关联 `olist_customers_dataset.customer_zip_code_prefix` 和 `olist_sellers_dataset.seller_zip_code_prefix`；州级业务分析优先用客户/卖家表里的 `customer_state` / `seller_state`，不要依赖本表。

# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `geolocation_zip_code_prefix` | string | first 5 digits of zip code |
| `geolocation_lat` | float64 | latitude |
| `geolocation_lng` | float64 | latitude |
| `geolocation_city` | string | city name |
| `geolocation_state` | string | state name |

# 数据采样

| geolocation_zip_code_prefix | geolocation_lat | geolocation_lng | geolocation_city | geolocation_state |
| --- | --- | --- | --- | --- |
| 01037 | -23.54562128115268 | -46.63929204800168 | sao paulo | SP |
| 01046 | -23.546081127035535 | -46.64482029837157 | sao paulo | SP |
| 01046 | -23.54612896641469 | -46.64295148361138 | sao paulo | SP |
| 01041 | -23.5443921648681 | -46.63949930627844 | sao paulo | SP |
| 01035 | -23.541577961711493 | -46.64160722329613 | sao paulo | SP |

# 关联关系

- `olist_customers_dataset`: `geolocation_zip_code_prefix` → 对应 `customer_zip_code_prefix`（一对多）
- `olist_sellers_dataset`: `geolocation_zip_code_prefix` → 对应 `seller_zip_code_prefix`（一对多）
