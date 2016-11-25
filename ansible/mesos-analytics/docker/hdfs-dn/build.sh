#!/bin/bash

export TAG=2.7

cat > Dockerfile <<EOL
FROM  $DOCKER_REGISTRY/hdfs-base:${TAG}
RUN chown -R hdfs /usr/local/hadoop/
USER hdfs
CMD ["hdfs", "datanode"]
EOL

sudo docker build -t $DOCKER_REGISTRY/hdfs-dn:${TAG} .
sudo docker push  $DOCKER_REGISTRY/hdfs-dn:${TAG} 
