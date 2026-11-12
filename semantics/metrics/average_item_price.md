# average_item_price

**Label:** Average item price  
**Type:** ratio  
**Description:** Item revenue divided by items sold.  
**Input metrics:** `item_revenue`, `items_sold`  
**Semantic models:** `order_items`  

## Dimensions

Group by or filter this metric with any of the dimensions below. `metric_time` accepts a granularity suffix: `metric_time__day`, `metric_time__week`, `metric_time__month`, `metric_time__quarter`, `metric_time__year`.

- `customer__customer_state`
- `customer__customer_type`
- `customer__first_order_ts`
- `metric_time`
- `order__customer__customer_state`
- `order__customer__customer_type`
- `order__customer__first_order_ts`
- `order__customer_state`
- `order__delivery_timeliness`
- `order__has_items`
- `order__order_status`
- `order__purchase_ts`
- `order_item__category_en`
- `order_item__customer_state`
- `order_item__order_status`
- `order_item__purchase_ts`
- `order_item__seller_state`
- `product__category_en`
- `product__first_seen_ts`
- `product__weight_band`
- `seller__first_seen_ts`
- `seller__seller_state`

## Query

Over time:
```json
{"metrics": ["average_item_price"], "group_by": ["metric_time__month"], "order_by": ["metric_time__month"]}
```

Broken down, filtered and ranked (see `../README.md` for every parameter):
```json
{"metrics": ["average_item_price"], "group_by": ["customer__customer_state"], "where": ["{{ Dimension('customer__customer_state') }} IS NOT NULL"], "order_by": ["-average_item_price"], "limit": 10}
```
