#!/usr/bin/env bash

set -e

echo "making get requests to http://localhost:8080 .... ctr+c to exit"
for i in `seq 1 3000`;
do
  curl http://localhost:8080 >/dev/null 2>&1 &
  sleep 0.01
done

wait
