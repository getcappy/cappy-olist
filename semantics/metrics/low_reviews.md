# low_reviews

**Label:** Low reviews  
**Type:** simple  
**Description:** Reviews with a score of 1 or 2.  
**Semantic models:** `reviews`  

## Dimensions

Group by or filter this metric with any of the dimensions below. `metric_time` accepts a granularity suffix: `metric_time__day`, `metric_time__week`, `metric_time__month`, `metric_time__quarter`, `metric_time__year`.

- `metric_time`
- `review__customer_state`
- `review__order_status`
- `review__review_creation_ts`
- `review__review_score`

## Query

Over time:
```json
{"metrics": ["low_reviews"], "group_by": ["metric_time__month"], "order_by": ["metric_time__month"]}
```

Broken down, filtered and ranked (see `../README.md` for every parameter):
```json
{"metrics": ["low_reviews"], "group_by": ["review__customer_state"], "where": ["{{ Dimension('review__customer_state') }} IS NOT NULL"], "order_by": ["-low_reviews"], "limit": 10}
```
