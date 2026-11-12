# average_delivery_days

**Label:** Average delivery days  
**Type:** simple  
**Description:** Average days from purchase to delivery for delivered orders.  
**Semantic models:** `orders`  

## Dimensions

Group by or filter this metric with any of the dimensions below. `metric_time` accepts a granularity suffix: `metric_time__day`, `metric_time__week`, `metric_time__month`, `metric_time__quarter`, `metric_time__year`.

- `customer__customer_state`
- `customer__customer_type`
- `customer__first_order_ts`
- `metric_time`
- `order__customer_state`
- `order__delivery_timeliness`
- `order__has_items`
- `order__order_status`
- `order__purchase_ts`

## Query

Over time:
```json
{"metrics": ["average_delivery_days"], "group_by": ["metric_time__month"], "order_by": ["metric_time__month"]}
```

Broken down, filtered and ranked (see `../README.md` for every parameter):
```json
{"metrics": ["average_delivery_days"], "group_by": ["customer__customer_state"], "where": ["{{ Dimension('customer__customer_state') }} IS NOT NULL"], "order_by": ["-average_delivery_days"], "limit": 10}
```
