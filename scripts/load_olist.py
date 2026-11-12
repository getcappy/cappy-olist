#!/usr/bin/env python3
"""Load the Olist Brazilian E-Commerce CSVs into the project's DuckDB warehouse.

The raw dataset is not committed to Git (45 MB compressed, ~250 MB on disk).
Download it from https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce and unpack
the nine CSVs into the directory passed as --raw-dir (default: ../olist-data/raw).

Usage:
    python scripts/load_olist.py --raw-dir ../olist-data/raw --db ../olist-data/olist.duckdb
"""

from __future__ import annotations

import argparse
from pathlib import Path

import duckdb

RAW_TABLES: dict[str, tuple[str, dict[str, str]]] = {
    "raw_orders": (
        "olist_orders_dataset.csv",
        {
            "order_id": "VARCHAR",
            "customer_id": "VARCHAR",
            "order_status": "VARCHAR",
            "order_purchase_timestamp": "TIMESTAMP",
            "order_approved_at": "TIMESTAMP",
            "order_delivered_carrier_date": "TIMESTAMP",
            "order_delivered_customer_date": "TIMESTAMP",
            "order_estimated_delivery_date": "TIMESTAMP",
        },
    ),
    "raw_customers": (
        "olist_customers_dataset.csv",
        {
            "customer_id": "VARCHAR",
            "customer_unique_id": "VARCHAR",
            "customer_zip_code_prefix": "VARCHAR",
            "customer_city": "VARCHAR",
            "customer_state": "VARCHAR",
        },
    ),
    "raw_order_items": (
        "olist_order_items_dataset.csv",
        {
            "order_id": "VARCHAR",
            "order_item_id": "INTEGER",
            "product_id": "VARCHAR",
            "seller_id": "VARCHAR",
            "shipping_limit_date": "TIMESTAMP",
            "price": "DECIMAL(12,2)",
            "freight_value": "DECIMAL(12,2)",
        },
    ),
    "raw_payments": (
        "olist_order_payments_dataset.csv",
        {
            "order_id": "VARCHAR",
            "payment_sequential": "INTEGER",
            "payment_type": "VARCHAR",
            "payment_installments": "INTEGER",
            "payment_value": "DECIMAL(12,2)",
        },
    ),
    "raw_reviews": (
        "olist_order_reviews_dataset.csv",
        {
            "review_id": "VARCHAR",
            "order_id": "VARCHAR",
            "review_score": "INTEGER",
            "review_comment_title": "VARCHAR",
            "review_comment_message": "VARCHAR",
            "review_creation_date": "TIMESTAMP",
            "review_answer_timestamp": "TIMESTAMP",
        },
    ),
    "raw_products": (
        "olist_products_dataset.csv",
        {
            "product_id": "VARCHAR",
            "product_category_name": "VARCHAR",
            "product_name_lenght": "INTEGER",
            "product_description_lenght": "INTEGER",
            "product_photos_qty": "INTEGER",
            "product_weight_g": "INTEGER",
            "product_length_cm": "INTEGER",
            "product_height_cm": "INTEGER",
            "product_width_cm": "INTEGER",
        },
    ),
    "raw_sellers": (
        "olist_sellers_dataset.csv",
        {
            "seller_id": "VARCHAR",
            "seller_zip_code_prefix": "VARCHAR",
            "seller_city": "VARCHAR",
            "seller_state": "VARCHAR",
        },
    ),
    "raw_category_translation": (
        "product_category_name_translation.csv",
        {
            "product_category_name": "VARCHAR",
            "product_category_name_english": "VARCHAR",
        },
    ),
    "raw_geolocation": (
        "olist_geolocation_dataset.csv",
        {
            "geolocation_zip_code_prefix": "VARCHAR",
            "geolocation_lat": "DOUBLE",
            "geolocation_lng": "DOUBLE",
            "geolocation_city": "VARCHAR",
            "geolocation_state": "VARCHAR",
        },
    ),
}


def load(raw_dir: Path, db_path: Path) -> None:
    missing = [name for name, _ in RAW_TABLES.values() if not (raw_dir / name).is_file()]
    if missing:
        raise SystemExit(f"Missing CSV files in {raw_dir}: {', '.join(missing)}")

    db_path.parent.mkdir(parents=True, exist_ok=True)
    con = duckdb.connect(str(db_path))
    try:
        for table, (filename, columns) in RAW_TABLES.items():
            types = "{" + ", ".join(f"'{column}': '{dtype}'" for column, dtype in columns.items()) + "}"
            con.execute(
                f"""
                CREATE OR REPLACE TABLE {table} AS
                SELECT * FROM read_csv(
                    '{raw_dir / filename}',
                    header = true,
                    delim = ',',
                    quote = '"',
                    escape = '"',
                    nullstr = [''],
                    types = {types}
                )
                """
            )
            count = con.execute(f"SELECT count(*) FROM {table}").fetchone()[0]
            print(f"{table:26} {count:>9,} rows  <- {filename}")

        con.execute("CHECKPOINT")
    finally:
        con.close()
    print(f"\nDuckDB warehouse: {db_path}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--raw-dir", type=Path, default=Path("../olist-data/raw"))
    parser.add_argument("--db", type=Path, default=Path("../olist-data/olist.duckdb"))
    args = parser.parse_args()
    load(args.raw_dir.resolve(), args.db.resolve())


if __name__ == "__main__":
    main()
