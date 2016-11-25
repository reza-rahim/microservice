#!/bin/bash

export TAG=2.0

cat > Dockerfile <<EOL
FROM $DOCKER_REGISTRY/spark-base:${TAG}

COPY spark-daemon.sh /usr/local/spark/sbin/spark-daemon.sh
COPY docker-entry.sh /usr/local/spark/sbin/docker-entry.sh

RUN chmod 755 /usr/local/spark/sbin/spark-daemon.sh
RUN chmod 755 /usr/local/spark/sbin/docker-entry.sh

RUN chown -R  spark /usr/local/spark

USER spark

CMD ["/usr/local/spark/sbin/docker-entry.sh"]
EOL

sudo docker build -t $DOCKER_REGISTRY/spark-master:${TAG} .
sudo docker push  $DOCKER_REGISTRY/spark-master:${TAG} 
