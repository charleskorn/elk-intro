#!/usr/bin/env bash

set -e

/opt/simple-app/simple-app-amd64-linux | logstash -f /conf/logstash.conf
