---
type: DuckDB Table
title: Olist Order Payments Dataset
description: This dataset includes data about the orders payment options.
---

# 描述

原始支付表，一行一笔支付（`order_id + payment_sequential`）。

- 一个订单可能有多笔支付（信用卡 + 优惠券、拆分支付、分期等）；按订单汇总前必须先 `SUM(payment_value) GROUP BY order_id`。
- `payment_type`：credit_card、boleto、voucher、debit_card、not_defined。
- 支付金额合计与商品+运费口径不同，不要混用。

Olist 数据集 `payment_type` 字段的 5 种取值，都是巴西常见的支付方式：

| 取值 | 中文名称 | 定义 | 大致占比 |
| --- | --- | --- | --- |
| `credit_card` | 信用卡 | 用信用卡支付。巴西最主流的在线支付方式，通常配合分期（对应 `payment_installments`，常见 2~12 期，商户或银行承担垫资）。 | ~74% |
| `boleto` | 银行付款单（Boleto Bancário） | 巴西特有的“现金类”支付：系统生成一张带条形码的付款凭证，客户去银行、ATM、邮局、彩票店或网银扫码/凭码付款。到账需 1~3 个工作日；类似现金支付，商家无拒付（chargeback）风险。 | ~19% |
| `voucher` | 代金券 / 礼品卡 | 平台或合作方发行的预付购物券/礼品卡抵扣。金额往往只覆盖订单一部分，所以经常和信用卡组合使用（表现为同一 `order_id` 下多行记录，靠 `payment_sequential` 区分）。 | ~6% |
| `debit_card` | 借记卡（储蓄卡） | 用借记卡支付，金额即时从客户银行账户扣划，无分期。 | ~1.5% |
| `not_defined` | 未定义 | 支付方式缺失/登记异常的极少数记录（整个数据集仅 3 笔，对应订单多为已取消状态），分析时一般直接排除。 | 极少（3 笔） |

*按支付记录笔数估算，不同清洗口径会略有差异。*

分析时的实用提示：

- `boleto`、`debit_card`、`not_defined` 的 `payment_installments` 恒为 1，只有 `credit_card` 才会出现多期。
- `voucher` 常作为“部分支付”出现在 `payment_sequential > 1` 的行里，单独看它的 `payment_value` 会低估订单金额——按 `order_id` 汇总时务必 `SUM(payment_value)`。

# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string | unique identifier of an order. |
| `payment_sequential` | int32 | a customer may pay an order with more than one payment method. If he does so, a sequence will be created to accommodate all |
| `payment_type` | string | method of payment chosen by the customer: credit_card、boleto、voucher、debit_card、not_defined。|
| `payment_installments` | int32 | number of installments chosen by the customer. 客户选择的分期付款期数（分几期支付）|
| `payment_value` | decimal(12, 2) | transaction value. |

# 数据采样

| order_id | payment_sequential | payment_type | payment_installments | payment_value |
| --- | --- | --- | --- | --- |
| b81ef226f3fe1789b1e8b2acac839d17 | 1 | credit_card | 8 | 99.33 |
| a9810da82917af2d9aefd1278f1dcfa0 | 1 | credit_card | 1 | 24.39 |
| 25e8ea4e93396b6fa0d3dd708e76c1bd | 1 | credit_card | 1 | 65.71 |
| ba78997921bbcdc1373bb41e913ab953 | 1 | credit_card | 8 | 107.78 |
| 42fdf880ba16b47b59251dd489d4441a | 1 | credit_card | 2 | 128.45 |

# 关联关系

- `olist_orders_dataset`：`order_id` → `order_id`（多对一）
