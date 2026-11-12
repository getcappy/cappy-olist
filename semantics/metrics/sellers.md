# sellers

**Label:** Sellers  
**Type:** simple  
**Description:** Number of sellers.  
**Semantic models:** `sellers`  

## Dimensions

Group by or filter this metric with any of the dimensions below. `metric_time` accepts a granularity suffix: `metric_time__day`, `metric_time__week`, `metric_time__month`, `metric_time__quarter`, `metric_time__year`.

- `metric_time`
- `seller__first_seen_ts`
- `seller__seller_state`

## Query

Over time:
```json
{"metrics": ["sellers"], "group_by": ["metric_time__month"], "order_by": ["metric_time__month"]}
```

Broken down, filtered and ranked (see `../README.md` for every parameter):
```json
{"metrics": ["sellers"], "group_by": ["seller__first_seen_ts"], "where": ["{{ Dimension('seller__first_seen_ts') }} IS NOT NULL"], "order_by": ["-sellers"], "limit": 10}
```
