# Update log

## 2026-11-12
* **Update**: Metrics and dimensions now query the 9 raw CSV tables directly, with the original table and column names. No views, no preprocessing layer.
* **Update**: Replaced the dbt MetricFlow semantic layer with OKF v0.2 markdown metric definitions computed through `execute_sql`.
* **Creation**: Established the Olist OKF bundle with 29 metric concepts and 13 dimension concepts.
