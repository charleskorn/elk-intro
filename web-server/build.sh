#!/usr/bin/env bash

set -e

echo "Compiling statically linked binary..."
CGO_ENABLED=0 GOOS=linux go build -o bin/web-server-amd64-linux -a -installsuffix cgo .

echo "Building Docker container..."
docker build -t web-server .

echo "Done."
