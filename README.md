# ELK Intro Using Docker
This project is a simple way to get up and running with the [Elasticsearch](https://www.elastic.co/) + [Logstash](https://www.elastic.co/products/logstash) + [Kibana](https://www.elastic.co/products/kibana) stack, commonly referred to as the ELK stack.

The intention is to understand its set up and configuration in depth with some simple examples of an application generating some simple logs and a web server logging its requests.

## Dependencies
* [Docker](https://docs.docker.com/engine/installation/)
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Golang 1.x](https://golang.org/dl/)
* [cURL](https://curl.haxx.se/download.html)

## How to Use
Once you have all the dependencies installed and correctly configured to bring up the ELK stack simply run
`./go.sh run`

This will start two applications which we will use to generate some log messages to send to our ELK setup:

* The first application (`simple-app`) is just a simple binary file which will generate a random magic number and log it.
* The second application (`web-server`) is a simple web server application which will log the requests sent to that web server.

The web server will be running on port 8080 so you can make requests to `localhost:8080` or you can run the `./makeRequests.sh` script which will do this for you.
You will need to run this in a separate terminal window after you have brought up the ELK stack.

## Credits

* [Joe Sustaric](https://github.com/joesustaric) for updating everything to use Docker Compose and writing a readme
