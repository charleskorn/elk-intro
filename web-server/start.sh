#!/usr/bin/env bash

set -e

echo "*** Building..."

./build.sh

echo "*** Starting Elasticsearch and Kibana..."

elasticsearchContainer=elasticsearch
kibanaContainer=kibana

docker run -d --name $elasticsearchContainer -p 9200:9200 elasticsearch:2.0 elasticsearch -Dnetwork.host=_non_loopback:ipv4_
docker run -d --name $kibanaContainer --link $elasticsearchContainer:elasticsearch -p 5601:5601 kibana:4.2

ip=$(docker-machine ip $(docker-machine ls --filter state=Running -q) || boot2docker ip)

echo "*** Elasticsearch is available at: http://$ip:9200"
echo "*** Kibana is available at: http://$ip:5601"

echo "*** Starting app..."

docker run --rm -t -i --name web-server -p 8080:8080 --link $elasticsearchContainer:elasticsearch web-server

echo "*** Cleaning up..."

docker stop $kibanaContainer $elasticsearchContainer
docker rm $kibanaContainer $elasticsearchContainer
