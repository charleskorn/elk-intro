#!/usr/bin/env bash

set -e

for i in `seq 1 3000`;
do
  curl http://localhost:8080 >/dev/null 2>&1 &
  sleep 0.01
done

wait
