#!/usr/bin/env bash

container=$(docker ps --filter image=simple-app --quiet)

if [ "$container" == "" ]; then
  echo "No container running."
  exit
fi

echo "Stopping $container..."

docker stop $container
