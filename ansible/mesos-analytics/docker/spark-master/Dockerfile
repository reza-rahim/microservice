FROM 10.0.15.11:5000/spark-base:2.0

COPY spark-daemon.sh /usr/local/spark/sbin/spark-daemon.sh
COPY docker-entry.sh /usr/local/spark/sbin/docker-entry.sh

RUN chmod 755 /usr/local/spark/sbin/spark-daemon.sh
RUN chmod 755 /usr/local/spark/sbin/docker-entry.sh

RUN chown -R  spark /usr/local/spark

USER spark

CMD ["/usr/local/spark/sbin/docker-entry.sh"]
