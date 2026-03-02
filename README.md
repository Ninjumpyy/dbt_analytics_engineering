# Analytics Engineering with dbt

## Introduction

This project implements an end-to-end analytics engineering workflow using **dbt** and **DuckDB**, based on the `jaffle_shop` ecommerce dataset.

The objective is to transform raw transactional data (customers, orders, payments) into analytics-ready models using a layered architecture:

- **Staging**: Clean and standardize raw data
- **Intermediate**: Derive reusable business logic
- **Marts**: Expose dimensional models for reporting and KPI analysis

## Architecture

The project follows a structured dependency flow:

- Raw CSV files are loaded as **seeds**
- `stg_*` models standardize and rename fields
- `int_*` models compute reusable metrics
- Final marts (`dim_customers`, `fct_orders`) expose analytics-ready tables

All dependencies are explicitly defined using `ref()` and `source()`, enabling full lineage tracking through `dbt docs`.

![Lineage Graph](docs/lineage_graph.png)

## Technology Used

### Platform

- Local environment (DuckDB)

### Tools

- dbt Core
- dbt-duckdb adapter
- GitHub Actions (CI)

### Languages

- SQL (transformations)
- Jinja (macros & templating)
- YAML (testing & documentation)

## Data Used

The dataset simulates a small ecommerce business:

- **Customers**: Basic customer attributes
- **Orders**: Order dates and lifecycle status
- **Payments**: Multiple payment methods per order

All raw data is stored as CSV files in `/seeds` and loaded into DuckDB via `dbt build`.

## Data Model

### dim_customers

One row per customer. Includes:

- First and most recent order
- Number of orders
- Repeat customer flag
- Customer lifetime value
- Average order value

### fct_orders

One row per order. Includes:

- Order status
- Payment method breakdown
- Total order amount
- Number of payments

The fact table is materialized incrementally.

## Project Implementation

The project uses dbt best practices:

- Layered architecture (staging → intermediate → marts)
- Reusable macros (`cents_to_dollars`, `get_payment_methods`)
- Relationship tests and accepted value constraints on categorical fields
- Incremental model configuration for fact table
- Automated CI validation with GitHub Actions

## How to run

```bash

# Clone the repository

git clone <repo_url>

cd dbt_analytics_engineering

# Create virtual environment

python -m venv .venv

# Activate the virtual environment

# On Mac/Linux

source .venv/bin/activate

# On Windows

.venv\Scripts\Activate.ps1

# Install dependencies

pip install dbt-duckdb

# Configure profiles

# On Mac/Linux

export DBT_PROFILES_DIR=profiles

# On Windows

$env:DBT_PROFILES_DIR="profiles"

# Run dbt commands

dbt build

```

## CI Pipeline

A GitHub Actions workflow runs on:

- Push to `main`
- Pull requests

The workflow executes:

- `dbt deps`
- `dbt build`

This ensures models, seeds, and tests pass before merging changes.

![dbt CI](https://github.com/Ninjumpyy/dbt_analytics_engineering/actions/workflows/dbt.yml/badge.svg)

## Future Improvements

This project could be extended by:

- Adding source freshness checks
- Introducing snapshot-based Slowly Changing Dimensions
- Deploying the project to a cloud data warehouse
- Adding a BI dashboard built on top of the marts


