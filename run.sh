#!/usr/bin/env bash
set -e

for i in "$@"
do
case $i in
    -r|--run)
    echo "Compiling statically linked binary..."
    cd simple-app
    CGO_ENABLED=0 GOOS=linux go build -o bin/simple-app-amd64-linux -a -installsuffix cgo .
    cd ..
    echo "Starting docker Containers..."
    docker-compose up --force-recreate
    echo "Cleaning up docker Containers..."
    docker-compose stop && docker-compose rm -f
    shift # past argument=value
    ;;
    -b|--build)
    echo $i
    shift # past argument=value
    ;;
    -t|--thing)
    echo $i
    shift # past argument=value
    ;;
    -h|--help)
    echo $i
    shift # past argument with no value
    ;;
    *)
            # unknown option (help)
    ;;
esac
done
