#!/usr/bin/env bash

set -e

ip=$(docker-machine ip $(docker-machine ls --filter state=Running -q) || boot2docker ip)

for i in `seq 1 3000`;
do
  curl http://$ip:8080 >/dev/null 2>&1 &
  sleep 0.01
done

wait
