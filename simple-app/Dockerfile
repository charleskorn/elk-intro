FROM logstash:2

RUN mkdir /app
COPY bin/simple-app-amd64-linux /app/simple-app

RUN mkdir /config
COPY logstash.conf /config/logstash.conf

RUN logstash -f /config/logstash.conf --configtest

CMD /app/simple-app | logstash -f /config/logstash.conf
