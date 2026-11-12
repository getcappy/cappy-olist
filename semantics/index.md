---
okf_version: "0.2"
---

# Olist Brazilian E-Commerce knowledge bundle

OKF (Open Knowledge Format) bundle for the Olist marketplace dataset. Each metric is one
concept with a sanctioned SQL computation; each dimension is one concept describing how to
slice it. Read the metric before writing SQL, and compute it with `execute_sql` on the
`olist` DuckDB database.

# Data

All computations read these 9 raw tables directly. Table names and columns match the Kaggle CSVs;
there are no views or derived tables.

* [olist_orders_dataset](../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md) - one row per order
* [olist_customers_dataset](../databases/type=duckdb/database=olist/schema=main/table=olist_customers_dataset.md) - one row per order-customer
* [olist_order_items_dataset](../databases/type=duckdb/database=olist/schema=main/table=olist_order_items_dataset.md) - one row per order item
* [olist_order_payments_dataset](../databases/type=duckdb/database=olist/schema=main/table=olist_order_payments_dataset.md) - one row per payment
* [olist_order_reviews_dataset](../databases/type=duckdb/database=olist/schema=main/table=olist_order_reviews_dataset.md) - one row per review
* [olist_products_dataset](../databases/type=duckdb/database=olist/schema=main/table=olist_products_dataset.md) - one row per product
* [olist_sellers_dataset](../databases/type=duckdb/database=olist/schema=main/table=olist_sellers_dataset.md) - one row per seller
* [product_category_name_translation](../databases/type=duckdb/database=olist/schema=main/table=product_category_name_translation.md) - Portuguese to English category names
* [olist_geolocation_dataset](../databases/type=duckdb/database=olist/schema=main/table=olist_geolocation_dataset.md) - one row per postal-code coordinate

# Metrics

## Revenue & orders

* [GMV](metrics/gmv.md) - Gross merchandise value: item prices plus freight, in BRL.
* [Merchandise value](metrics/merchandise-value.md) - Item prices excluding freight, in BRL.
* [Freight value](metrics/freight-value.md) - Freight charged to customers, in BRL.
* [Orders](metrics/orders.md) - Number of orders placed.
* [Delivered orders](metrics/delivered-orders.md) - Orders with status delivered.
* [Canceled orders](metrics/canceled-orders.md) - Orders with status canceled.
* [Average order value (AOV)](metrics/average-order-value.md) - GMV divided by the number of orders.
* [Cancellation rate](metrics/cancellation-rate.md) - Canceled orders divided by all orders.

## Delivery performance

* [Late orders](metrics/late-orders.md) - Delivered orders that arrived after the estimated delivery date.
* [Late delivery rate](metrics/late-delivery-rate.md) - Late delivered orders divided by delivered orders.
* [Average delivery days](metrics/average-delivery-days.md) - Average days from purchase to delivery for delivered orders.

## Products & sellers

* [Items sold](metrics/items-sold.md) - Number of order items (units) sold.
* [Item revenue](metrics/item-revenue.md) - Item prices excluding freight.
* [Item freight](metrics/item-freight.md) - Freight on order items.
* [Average item price](metrics/average-item-price.md) - Item revenue divided by items sold.
* [Catalogue products](metrics/catalog-products.md) - Number of products in the catalogue.
* [Sellers](metrics/sellers.md) - Number of sellers.

## Customers

* [Customers](metrics/customers.md) - Number of distinct customers.
* [Repeat customers](metrics/repeat-customers.md) - Customers with more than one order.
* [Repeat customer rate](metrics/repeat-customer-rate.md) - Repeat customers divided by all customers.
* [Average customer value](metrics/average-customer-value.md) - Average lifetime GMV per customer.
* [Average orders per customer](metrics/average-orders-per-customer.md) - Average number of orders per customer.

## Payments

* [Payment value](metrics/payment-value.md) - Total value collected through payments.
* [Payment transactions](metrics/payment-transactions.md) - Number of payment transactions.
* [Average payment value](metrics/average-payment-value.md) - Payment value divided by payment transactions.

## Reviews

* [Average review score](metrics/average-review-score.md) - Average customer review score from 1 to 5.
* [Reviews](metrics/reviews.md) - Number of reviews.
* [Low reviews](metrics/low-reviews.md) - Reviews with a score of 1 or 2.
* [Low review rate](metrics/low-review-rate.md) - Low reviews divided by all reviews.

# Dimensions

* [Order date](dimensions/date.md) - Date the order was placed (purchase timestamp).
* [Order status](dimensions/order-status.md) - Order lifecycle status.
* [Customer state](dimensions/customer-state.md) - Two-letter Brazilian state of the customer.
* [Delivery timeliness](dimensions/delivery-timeliness.md) - Whether a delivered order arrived late.
* [Product category](dimensions/category.md) - Product category in English.
* [Seller state](dimensions/seller-state.md) - Two-letter Brazilian state of the seller.
* [Payment type](dimensions/payment-type.md) - Payment method used for a transaction.
* [Instalment band](dimensions/installment-band.md) - Number of payment instalments grouped into bands.
* [Review score](dimensions/review-score.md) - Customer review score from 1 to 5.
* [Customer type](dimensions/customer-type.md) - Repeat versus one-time customer.
* [Weight band](dimensions/weight-band.md) - Product weight grouped into bands.
* [Customer first order date](dimensions/customer-first-order-date.md) - Month of the customer's first order.
* [Review date](dimensions/review-date.md) - Date the review was created.

# Conventions

- **Metric** concepts use `type: Metric` and carry `unit`, `aliases` and `sources`.
- `# Computation` is the sanctioned SQL. Adapt filters and `GROUP BY`, but keep the aggregation formula.
- `# Notes` records baselines and caveats; treat them as part of the definition.
- Dimension concepts use `type: Dimension` and show the SQL expression and available tables.

# Outside this bundle

Cappy's table documentation lives outside the OKF bundle:

- [Table docs](../databases/type=duckdb/database=olist/schema=main/)
- [Project rules](../RULES.md)
- [Data dictionary](../docs/olist-data-dictionary.md)
