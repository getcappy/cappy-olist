# brazilian-ecommerce

Olist 巴西电商数据集（Kaggle）的 cappy 分析项目。

**不做任何数据处理**：DuckDB 里只有 9 张原始表，表名和列名与 Kaggle CSV 完全一致；没有
`stg_*` / `fct_*` / `dim_*` 视图。指标以 **OKF v0.2** markdown 概念文件定义在 `semantics/`，
由 cappy agent 读取后用 `execute_sql` 直接在原始表上计算。

## 结构

```text
config.yaml                   # DuckDB 数据源，include main.olist_* + product_category_name_translation
RULES.md                      # 业务规则、关联/去重、指标口径、分析流程
databases/                    # cappy sync 生成的 9 张原始表文档（描述/关联关系为手写）
semantics/                    # OKF 知识包
  index.md                    #   入口：29 指标 / 13 维度
  log.md                      #   变更记录
  metrics/<metric>.md         #   type: Metric，Definition / Computation / Dimensions / Notes
  dimensions/<dim>.md         #   type: Dimension，Definition / SQL / Available in / Notes
scripts/load_olist.py         # 9 个 CSV → 9 张同名 DuckDB 表
scripts/validate_okf.py       # 校验 OKF frontmatter 与内部链接
docs/olist-data-dictionary.md # 原始字段、关联、指标公式与全量基线
tests/                        # cappy test 评测用例（指标口径回归）
```

数据文件不在仓库内：CSV 和 DuckDB 放在项目上一级的 `olist-data/`。

## 从零复现

```bash
# 1. 下载 Kaggle 数据，解压 9 个 CSV 到 ../olist-data/raw
#    https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

# 2. 导入 9 张原始表（不做 rename / 聚合 / 去重）
pip install duckdb
python scripts/load_olist.py

# 3. 校验 OKF 与生成表文档
python scripts/validate_okf.py
cappy sync
```

## 语义模型（OKF）

29 个指标、13 个维度，入口是 `semantics/index.md`。每个指标一个 markdown 概念文件，例如
`semantics/metrics/gmv.md`：

```markdown
---
type: Metric
title: GMV
unit: BRL
aliases: ["revenue", "营收", "销售额"]
---
# Definition
...
# Computation
WITH order_gmv AS (
    SELECT o.order_id, COALESCE(SUM(i.price + i.freight_value), 0) AS gmv
    FROM olist_orders_dataset AS o
    LEFT JOIN olist_order_items_dataset AS i ON o.order_id = i.order_id
    GROUP BY o.order_id
)
SELECT SUM(gmv) AS gmv FROM order_gmv;
# Dimensions
- [Order date](/dimensions/date.md)
...
# Notes
- Full-period baseline: 15,843,553.24 BRL.
```

agent 的使用方式：

1. 读 `semantics/index.md` 或用别名 grep 找到指标文件；
2. 读 `# Computation`，用 `execute_sql` 执行；
3. 按 `# Dimensions` 里的维度表达式切分；比率指标先聚合分子分母再相除；
4. 商品/支付先聚合到 `order_id`，评价先按订单去重，客户用 `customer_unique_id`。

指标定义见 `semantics/metrics/`，维度见 `semantics/dimensions/`，业务口径见 `RULES.md`。
