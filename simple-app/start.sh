#!/usr/bin/env bash

set -e

echo "*** Building..."

./build.sh

echo "*** Starting Elasticsearch and Kibana..."

elasicsearchContainer=elasticsearch
kibanaContainer=kibana

docker run -d --name $elasicsearchContainer -p 9200:9200 elasticsearch:2.0 elasticsearch -Dnetwork.host=_non_loopback:ipv4_
docker run -d --name $kibanaContainer --link $elasicsearchContainer:elasticsearch -p 5601:5601 kibana:4.2

ip=$(docker-machine ip $(docker-machine ls --filter state=Running -q) || boot2docker ip)

echo "*** Elasticsearch is available at: http://$ip:9200"
echo "*** Kibana is available at: http://$ip:5601"

echo "*** Starting app..."

docker run --rm -t -i --name simple-app simple-app

echo "*** Cleaning up..."

docker stop $kibanaContainer && docker rm $kibanaContainer
docker stop $elasicsearchContainer && docker rm $elasicsearchContainer
