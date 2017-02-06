#!/bin/bash
set -e

# install OpenSSL libs for wget https
# update tar to use --strip-components flag
apk update
apk --update add tar
apk --no-cache add openssl ca-certificates wget
update-ca-certificates

# check for mandatory environment variables and exit if not defined
# [[ -z "$JDBC_LIB_URLS" ]] && { echo "Please specify comma-separated JDBC jar urls." ; exit 1; }
[[ -z "$STREAMSETS_LIBRARIES_EXTRA_DIR" ]] && { echo "Please specify where to store the JDBC libraries." ; exit 1; }

## make sure we're in the dir that Streamsets expects the JDBC jars to be in
## and that the dir exists or create it if it doesn't
mkdir -p "$STREAMSETS_LIBRARIES_EXTRA_DIR/streamsets-datacollector-jdbc-lib/lib/"
cd "$STREAMSETS_LIBRARIES_EXTRA_DIR/streamsets-datacollector-jdbc-lib/lib/"

## MYSQL_JDBC_URL="https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.0.8.tar.gz"
MARIADB_JDBC_URL="https://downloads.mariadb.com/Connectors/java/connector-java-1.5.7/mariadb-java-client-1.5.7.jar"
POSTGRES_JDBC_URL="https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar"

## the MySQL jar extracts into a folder, make sure to strip that folder
#wget --no-clobber "$MYSQL_JDBC_URL" -O - | tar -xz --strip-components=1

## the MariaDB jar is just a ... jar.
wget --no-clobber "$MARIADB_JDBC_URL"

## the PostgreSQL jar is just a ... jar.
wget --no-clobber "$POSTGRES_JDBC_URL"
