# catalog_products

**Label:** Catalogue products  
**Type:** simple  
**Description:** Number of products in the catalogue.  
**Semantic models:** `products`  

## Dimensions

Group by or filter this metric with any of the dimensions below. `metric_time` accepts a granularity suffix: `metric_time__day`, `metric_time__week`, `metric_time__month`, `metric_time__quarter`, `metric_time__year`.

- `metric_time`
- `product__category_en`
- `product__first_seen_ts`
- `product__weight_band`

## Query

Over time:
```json
{"metrics": ["catalog_products"], "group_by": ["metric_time__month"], "order_by": ["metric_time__month"]}
```

Broken down, filtered and ranked (see `../README.md` for every parameter):
```json
{"metrics": ["catalog_products"], "group_by": ["product__category_en"], "where": ["{{ Dimension('product__category_en') }} IS NOT NULL"], "order_by": ["-catalog_products"], "limit": 10}
```
