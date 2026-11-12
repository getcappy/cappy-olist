# brazilian-ecommerce

Olist 巴西电商数据集（Kaggle）的 cappy 分析项目：DuckDB 数据仓库 + 纯 SQL 星型模型 +
**OKF（Open Knowledge Format v0.2）** markdown 指标/维度定义。

不使用 dbt，也不使用 MetricFlow；指标由 cappy agent 读取 `semantics/metrics/*.md` 后通过
`execute_sql` 按受控口径计算。

## 结构

```text
config.yaml                   # DuckDB 数据源（无 semantic_layer 配置）
RULES.md                      # 业务规则、指标口径、分析流程
databases/                    # cappy sync 生成的表文档（描述/关联关系为手写）
semantics/                    # OKF 知识包
  index.md                    #   入口：29 指标 / 13 维度
  log.md                      #   变更记录
  metrics/<metric>.md         #   type: Metric，Definition / Computation / Dimensions / Notes
  dimensions/<dim>.md         #   type: Dimension，Definition / SQL / Available in / Notes
sql/build_warehouse.sql       # 纯 SQL 构建 stg_* / fct_* / dim_* 视图
scripts/load_olist.py         # CSV → DuckDB raw_* 表
scripts/build_marts.py        # 执行 sql/build_warehouse.sql
scripts/validate_okf.py       # 校验 OKF frontmatter 与内部链接
docs/olist-data-dictionary.md # 数据字典、指标公式与全量基线
tests/                        # cappy test 评测用例（指标口径回归）
```

数据文件不在仓库内：CSV 和 DuckDB 放在项目上一级的 `olist-data/`。

## 从零复现

```bash
# 1. 下载 Kaggle 数据，解压 9 个 CSV 到 ../olist-data/raw
#    https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

# 2. 建 DuckDB（raw 表）
pip install duckdb
python scripts/load_olist.py

# 3. 建分析层视图 + 校验 OKF
python scripts/build_marts.py
python scripts/validate_okf.py

# 4. 重新生成表文档
cappy sync

# 5. 提交并推送上下文，cappy 会在收到 push 后重新同步 checkout
git add -A && git commit -m "Add Olist DuckDB warehouse and OKF metrics" && git push
```

## 语义模型（OKF）

29 个指标、13 个维度，入口是 `semantics/index.md`。每个指标一个 markdown 概念文件，例如
`semantics/metrics/gmv.md`：

```markdown
---
type: Metric
title: "GMV"
unit: BRL
aliases: ["revenue", "营收", "销售额"]
---
# Definition
...
# Computation
SELECT SUM(gmv) AS gmv FROM fct_orders;
# Dimensions
- [Order date](/dimensions/date.md)
...
# Notes
- Full-period baseline: 15,843,553.24 BRL.
```

agent 的使用方式：

1. 读 `semantics/index.md` 或用别名 grep 找到指标文件；
2. 读 `# Computation`，用 `execute_sql` 执行；
3. 按 `# Dimensions` 里的维度表达式切分，比率指标先聚合分子分母再相除。

指标定义见 `semantics/metrics/`，维度见 `semantics/dimensions/`，业务口径见 `RULES.md`。
