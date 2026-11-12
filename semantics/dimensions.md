# Dimensions

Every dimension exposed by the semantic layer, named `entity__dimension` as expected by `execute_semantic_query`. Time dimensions accept a granularity suffix (e.g. `booking__ds__month`).

| Dimension | Type | Granularity | Semantic model | Description |
| --- | --- | --- | --- | --- |
| `customer__customer_state` | categorical |  | `customers` | Two-letter Brazilian state of the customer. |
| `customer__customer_type` | categorical |  | `customers` | `repeat` when the customer placed more than one order, `one_time` otherwise. |
| `customer__first_order_ts` | time | day | `customers` | Timestamp of the customer's first order. |
| `order__customer_state` | categorical |  | `orders` | Two-letter Brazilian state of the customer. |
| `order__delivery_timeliness` | categorical |  | `orders` | 'late' when the order was delivered after the estimated delivery date, 'on_time' otherwise. Only delivered orders can be late. |
| `order__has_items` | categorical |  | `orders` | Whether the order has at least one order item row. |
| `order__order_status` | categorical |  | `orders` | Order lifecycle status (delivered, shipped, canceled, unavailable, invoiced, processing, created, approved). |
| `order__purchase_ts` | time | day | `orders` | Timestamp when the customer placed the order. |
| `order_item__category_en` | categorical |  | `order_items` | Product category in English (unknown when the product has no category). |
| `order_item__customer_state` | categorical |  | `order_items` | Two-letter Brazilian state of the customer. |
| `order_item__order_status` | categorical |  | `order_items` | Order lifecycle status of the parent order. |
| `order_item__purchase_ts` | time | day | `order_items` | Timestamp when the order was placed. |
| `order_item__seller_state` | categorical |  | `order_items` | Two-letter Brazilian state of the seller. |
| `payment__installment_band` | categorical |  | `payments` | Number of instalments grouped into bands. |
| `payment__order_status` | categorical |  | `payments` | Order lifecycle status of the parent order. |
| `payment__payment_type` | categorical |  | `payments` | Payment method (credit_card, boleto, voucher, debit_card, not_defined). |
| `payment__purchase_ts` | time | day | `payments` | Timestamp when the order was placed. |
| `product__category_en` | categorical |  | `products` | Product category in English (unknown when the product has no category). |
| `product__first_seen_ts` | time | day | `products` | Timestamp of the product's first sale (null when never sold). |
| `product__weight_band` | categorical |  | `products` | Product weight grouped into bands. |
| `review__customer_state` | categorical |  | `reviews` | Two-letter Brazilian state of the customer. |
| `review__order_status` | categorical |  | `reviews` | Order lifecycle status of the reviewed order. |
| `review__review_creation_ts` | time | day | `reviews` | Timestamp when the review was created. |
| `review__review_score` | categorical |  | `reviews` | Review score from 1 (worst) to 5 (best). |
| `seller__first_seen_ts` | time | day | `sellers` | Timestamp of the seller's first sale (null when never sold). |
| `seller__seller_state` | categorical |  | `sellers` | Two-letter Brazilian state of the seller. |
