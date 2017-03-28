#!/bin/bash
set -e

# install OpenSSL libs for wget https
# update tar to use --strip-components flag
apk update
apk --update add tar
apk --no-cache add openssl ca-certificates wget
update-ca-certificates

# check for mandatory environment variables and exit if not defined
[[ -z "$STREAMSETS_LIBRARIES_EXTRA_DIR" ]] && { echo "Please specify where to store the JDBC libraries." ; exit 1; }

JDBC_STAGE_FOLDER="streamsets-datacollector-jdbc-lib"
MYSQL_BINLOG_STAGE_FOLDER="streamsets-datacollector-mysql-binlog-lib"

## create folders if they don't already exist 
mkdir -p $STREAMSETS_LIBRARIES_EXTRA_DIR/{$JDBC_STAGE_FOLDER,$MYSQL_BINLOG_STAGE_FOLDER}/lib/

## copy the baked-in JDBC jars to the JDBC libs folder
cp /jdbc-libs/* $STREAMSETS_LIBRARIES_EXTRA_DIR/$JDBC_STAGE_FOLDER/lib/
cp /jdbc-libs/* $STREAMSETS_LIBRARIES_EXTRA_DIR/$MYSQL_BINLOG_STAGE_FOLDER/lib/

