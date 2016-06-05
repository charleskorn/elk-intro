#!/usr/bin/env bash

set -e

function main {
  case "$1" in

  build)
    build
    ;;

  run)
    run
    ;;

  *)
    help
    exit 1
    ;;

  esac
}

function build {
  echo "Compiling all binary dependencies..."
  cd simple-app
  CGO_ENABLED=0 GOOS=linux go build -o bin/simple-app-amd64-linux -a -installsuffix cgo .
  cd ../web-server
  GOBIN=$GOPATH/bin go get ./...
  CGO_ENABLED=0 GOOS=linux go build -o bin/web-server-amd64-linux -a -installsuffix cgo .
  cd ..
}

function run {
  build
  echo "Starting Docker containers..."
  docker-compose up --force-recreate
  echo "Cleaning up Docker containers..."
  docker-compose stop && docker-compose rm -f
}

function help {
  echo "Usage"
  echo "go.sh run    = build applications and run the ELK stack"
  echo "go.sh build  = build the application binaries only"
  echo "Use Ctrl+C to shutdown the ELK stack once it is running."
}

main "$@"
