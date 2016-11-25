#!/bin/bash

export TAG=2.7

cat > Dockerfile <<EOL
FROM $DOCKER_REGISTRY/hdfs-base:${TAG}
COPY core-site.xml /usr/local/hadoop/etc/hadoop/
COPY hdfs-site.xml /usr/local/hadoop/etc/hadoop/
COPY hdfs-nn.sh /usr/local/hadoop/bin/hdfs-nn.sh
RUN chmod 755 /usr/local/hadoop/bin/hdfs-nn.sh
RUN chown -R hdfs /usr/local/hadoop/

USER hdfs
CMD ["hdfs-nn.sh"]
EOL

sudo docker build -t $DOCKER_REGISTRY/hdfs-nn:${TAG} .
sudo docker push  $DOCKER_REGISTRY/hdfs-nn:${TAG} 
