#!/bin/bash
set -e

# check for mandatory environment variables and exit if not defined
# [[ -z "$JDBC_LIB_URLS" ]] && { echo "Please specify comma-separated JDBC jar urls." ; exit 1; }
[[ -z "$STREAMSETS_LIBRARIES_EXTRA_DIR" ]] && { echo "Please specify where to store the JDBC libraries." ; exit 1; }

## make sure we're in the dir that Streamsets expects the JDBC jars to be in
cd "$STREAMSETS_LIBRARIES_EXTRA_DIR/streamsets-datacollector-jdbc-lib/lib/"

MYSQL_JDBC_URL="https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.0.8.tar.gz"
POSTGRES_JDBC_URL="https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar"

## the MySQL jar extracts into a folder, make sure to strip that folder
wget "$MYSQL_JDBC_URL" -O - | tar -xz --strip-components=1

## the PostgreSQL jar is just a ... jar.
wget "$POSTGRES_JDBC_URL"
