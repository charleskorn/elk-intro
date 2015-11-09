FROM logstash:2.0

RUN mkdir /app
COPY bin/web-server-amd64-linux /app/web-server

RUN mkdir /config
COPY logstash.conf /config/logstash.conf

RUN logstash -f /config/logstash.conf --configtest

CMD /app/web-server | logstash -f /config/logstash.conf
