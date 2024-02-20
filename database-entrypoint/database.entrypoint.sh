#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;

# 啟動 PostgreSQL 並創建資料庫
psql -v ON_ERROR_STOP=1 --username "$postgres_user" --dbname "$postgres_database" <<-EOSQL
  CREATE DATABASE $postgres_database;
  GRANT ALL PRIVILEGES ON DATABASE $postgres_database TO $postgres_user;
EOSQL

# 連接到新建的資料庫
psql -v ON_ERROR_STOP=1 --username "$postgres_user" --dbname "$postgres_database" <<-EOSQL
  BEGIN;
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    CREATE EXTENSION postgis;
  COMMIT;
EOSQL
