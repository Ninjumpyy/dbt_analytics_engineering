# Analytics Engineering with dbt

## Lineage Graph

The project follows a layered architecture (staging → intermediate → marts) with clear dependency separation.

![Lineage Graph](docs/lineage_graph.png)

## How to Run

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

### Badge
![dbt CI](https://github.com/Ninjumpyy/dbt_analytics_engineering/actions/workflows/dbt.yml/badge.svg)