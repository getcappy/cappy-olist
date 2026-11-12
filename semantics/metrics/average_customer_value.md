# average_customer_value

**Label:** Average customer value  
**Type:** simple  
**Description:** Average lifetime GMV per customer.  
**Semantic models:** `customers`  

## Dimensions

Group by or filter this metric with any of the dimensions below. `metric_time` accepts a granularity suffix: `metric_time__day`, `metric_time__week`, `metric_time__month`, `metric_time__quarter`, `metric_time__year`.

- `customer__customer_state`
- `customer__customer_type`
- `customer__first_order_ts`
- `metric_time`

## Query

Over time:
```json
{"metrics": ["average_customer_value"], "group_by": ["metric_time__month"], "order_by": ["metric_time__month"]}
```

Broken down, filtered and ranked (see `../README.md` for every parameter):
```json
{"metrics": ["average_customer_value"], "group_by": ["customer__customer_state"], "where": ["{{ Dimension('customer__customer_state') }} IS NOT NULL"], "order_by": ["-average_customer_value"], "limit": 10}
```
