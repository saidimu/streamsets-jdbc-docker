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

## make sure we're in the dir that Streamsets expects the JDBC jars to be in
## and that the dir exists or create it if it doesn't
mkdir -p "$STREAMSETS_LIBRARIES_EXTRA_DIR/streamsets-datacollector-jdbc-lib/lib/"
cd "$STREAMSETS_LIBRARIES_EXTRA_DIR/streamsets-datacollector-jdbc-lib/lib/"

## copy the baked-in JDBC jars to the Streamsets folder
cp /jdbc-libs/* .
