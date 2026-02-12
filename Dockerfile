FROM apache/airflow:3.1.7

# Switch to root to install system dependencies (if needed)
USER root
# (Optional) Install git or other OS tools here if you need them later
# RUN apt-get update && apt-get install -y git

# Install system dependencies required to build psycopg2 and dbt-postgres
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the airflow user to install python packages
USER airflow

# Copy your requirements file into the container
COPY requirements.txt .

# Install your dependencies (including the FAB provider)
RUN pip install --no-cache-dir -r requirements.txt