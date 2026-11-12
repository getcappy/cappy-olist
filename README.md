# brazilian-ecommerce

Olist 巴西电商数据集（Kaggle）的 cappy 分析项目：DuckDB 数据仓库 + dbt 星型模型 + MetricFlow 语义层。

## 结构

```text
config.yaml                 # DuckDB 数据源 + MetricFlow 语义层
RULES.md                    # 业务规则、指标口径、分析流程
databases/                  # cappy sync 生成的表文档（描述/关联关系为手写）
semantics/
  semantic_manifest.json    # dbt parse 产物，cappy 的语义层输入
  metrics/, dimensions.md   # cappy sync 生成的指标/维度文档
  olist_dbt/                # dbt 项目（staging / marts / semantic models）
docs/olist-data-dictionary.md
scripts/load_olist.py       # CSV → DuckDB raw 表
scripts/build_semantics.sh  # dbt run + dbt parse + cappy sync
tests/                      # cappy test 评测用例（指标口径回归）
data 目录不在仓库内：数据集放在 ../../olist-data/（相对项目根目录为 ../olist-data）
```

## 从零复现

```bash
# 1. 下载 Kaggle 数据，解压 9 个 CSV 到 ../olist-data/raw
#    https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

# 2. 建 DuckDB（raw 表）
pip install duckdb
python scripts/load_olist.py

# 3. 建星型模型 + 语义 manifest
pip install dbt-duckdb "metricflow>=0.213,<0.214"
export OLIST_DUCKDB_PATH="$(cd .. && pwd)/olist-data/olist.duckdb"
./scripts/build_semantics.sh

# 4. 提交并推送上下文，cappy 会在收到 push 后重新同步 checkout
git add -A && git commit -m "Add Olist DuckDB warehouse and semantic layer" && git push
```

## 语义层

29 个指标 / 26 个维度，覆盖 GMV、订单、客单价、取消率、延迟率、销量、类目、客户复购、
支付方式和评价。查询示例：

```json
{"metrics": ["gmv", "orders", "average_order_value"], "group_by": ["order__customer_state"], "order_by": ["-gmv"], "limit": 10}
```

指标定义见 `semantics/metrics/`，维度见 `semantics/dimensions.md`，业务口径见 `RULES.md`。
