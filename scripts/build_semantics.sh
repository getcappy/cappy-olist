#!/usr/bin/env bash
# Rebuild the DuckDB marts and the MetricFlow manifest after changing models.
#
#   OLIST_DUCKDB_PATH=/path/to/olist.duckdb ./scripts/build_semantics.sh
#
# Requires dbt-duckdb and metricflow in the environment (`pip install dbt-duckdb "metricflow>=0.213,<0.214"`).
set -euo pipefail

cd "$(dirname "$0")/.."

export OLIST_DUCKDB_PATH="${OLIST_DUCKDB_PATH:-$(cd .. && pwd)/olist-data/olist.duckdb}"
DBT_BIN="${DBT_BIN:-dbt}"

echo "==> dbt run   (DuckDB: $OLIST_DUCKDB_PATH)"
"$DBT_BIN" run --project-dir semantics/olist_dbt --profiles-dir semantics/olist_dbt

echo "==> dbt parse (MetricFlow semantic manifest)"
"$DBT_BIN" parse --project-dir semantics/olist_dbt --profiles-dir semantics/olist_dbt

cp semantics/olist_dbt/target/semantic_manifest.json semantics/semantic_manifest.json

echo "==> cappy sync"
cappy sync
