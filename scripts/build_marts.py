#!/usr/bin/env python3
"""Create the Olist staging and mart views in DuckDB.

The DDL lives in ``sql/build_warehouse.sql``; this script only resolves paths,
executes it, and prints row counts so a rebuild is easy to verify.

Usage:
    python scripts/build_marts.py
    python scripts/build_marts.py --db /path/to/olist.duckdb
"""

from __future__ import annotations

import argparse
from pathlib import Path

import duckdb

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DB = ROOT.parent / "olist-data" / "olist.duckdb"
SQL_FILE = ROOT / "sql" / "build_warehouse.sql"
MART_TABLES = (
    "fct_orders",
    "fct_order_items",
    "fct_payments",
    "fct_reviews",
    "dim_customers",
    "dim_products",
    "dim_sellers",
    "dim_geolocation",
)


def build(db_path: Path) -> None:
    if not db_path.is_file():
        raise SystemExit(f"DuckDB warehouse not found at {db_path}. Run scripts/load_olist.py first.")

    con = duckdb.connect(str(db_path))
    try:
        raw_count = con.execute(
            "SELECT count(*) FROM duckdb_tables() WHERE table_name LIKE 'raw_%'"
        ).fetchone()[0]
        if not raw_count:
            raise SystemExit("No raw_* tables found. Run scripts/load_olist.py first.")

        con.execute(SQL_FILE.read_text())
        con.execute("CHECKPOINT")

        print(f"Built {len(MART_TABLES)} mart views in {db_path}")
        for table in MART_TABLES:
            count = con.execute(f"SELECT count(*) FROM {table}").fetchone()[0]
            print(f"  {table:22} {count:>9,} rows")
    finally:
        con.close()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--db", type=Path, default=DEFAULT_DB)
    args = parser.parse_args()
    build(args.db.resolve())


if __name__ == "__main__":
    main()
