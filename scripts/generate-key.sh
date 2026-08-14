#!/usr/bin/env bash
set -euo pipefail

DIR="$HOME/.garmin"
mkdir -p "$DIR"
openssl genrsa -out "$DIR/developer_key.pem" 4096
openssl pkcs8 -topk8 -inform PEM -outform DER \
  -in "$DIR/developer_key.pem" \
  -out "$DIR/developer_key.der" -nocrypt
chmod 600 "$DIR/developer_key.pem" "$DIR/developer_key.der"
echo "Created $DIR/developer_key.der"
