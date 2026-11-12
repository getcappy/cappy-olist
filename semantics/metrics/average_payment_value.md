# average_payment_value

**Label:** Average payment value  
**Type:** ratio  
**Description:** Payment value divided by payment transactions.  
**Input metrics:** `payment_value`, `payment_transactions`  
**Semantic models:** `payments`  

## Dimensions

Group by or filter this metric with any of the dimensions below. `metric_time` accepts a granularity suffix: `metric_time__day`, `metric_time__week`, `metric_time__month`, `metric_time__quarter`, `metric_time__year`.

- `metric_time`
- `order__customer__customer_state`
- `order__customer__customer_type`
- `order__customer__first_order_ts`
- `order__customer_state`
- `order__delivery_timeliness`
- `order__has_items`
- `order__order_status`
- `order__purchase_ts`
- `payment__installment_band`
- `payment__order_status`
- `payment__payment_type`
- `payment__purchase_ts`

## Query

Over time:
```json
{"metrics": ["average_payment_value"], "group_by": ["metric_time__month"], "order_by": ["metric_time__month"]}
```

Broken down, filtered and ranked (see `../README.md` for every parameter):
```json
{"metrics": ["average_payment_value"], "group_by": ["order__customer__customer_state"], "where": ["{{ Dimension('order__customer__customer_state') }} IS NOT NULL"], "order_by": ["-average_payment_value"], "limit": 10}
```
