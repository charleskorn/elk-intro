# ELK Intro Using Docker
This project is a simple way to get up and running with the [Elasticsearch](https://www.elastic.co/) + [Logstash](https://www.elastic.co/products/logstash) + [Kibana](https://www.elastic.co/products/kibana) stack (Commonly referred to as ELK stack).  
The intention is to understand it's set up and configuration more in depth with some simple examples of an application logging and a web server logging.

### Dependencies
[Docker](https://docs.docker.com/engine/installation/)  
[Docker Compose](https://docs.docker.com/compose/install/)  
[Golang 1.x](https://golang.org/dl/)  
[cURL](https://curl.haxx.se/download.html)  

### How to Use
Once you have all the dependencies installed and correctly configured to bring up the ELK stack simply run  
`$ ./go.sh run`  

This will start two application which we will use to generate some log messages which we will use to send to this ELK setup.  
The first application is just a simple binary file which will just generate a random magic number and log it. (/simple-app)  
The second application is a simple web server application which will just log the request sent to that web server. (/web-server)  

The web server will be running on port 8080 so you can make requests to `localhost::8080` or you can run the `./makeRequests.sh` script which will do this for you. You will need to run this in a separate window after you have brought up the ELK stack.
