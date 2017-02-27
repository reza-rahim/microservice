#!/bin/bash

${KAFKA_SCALA_VERSION?"Need to set KAFKA_SCALA_VERSION"}
${KAFKA_VERSION?"Need to set KAFKA_VERSION"}

cat Dockerfile.template | \
sed -e "s/{{ KAFKA_SCALA_VERSION }}/$KAFKA_SCALA_VERSION/" \
    -e "s/{{ KAFKA_VERSION }}/$KAFKA_VERSION/" \
> Dockerfile

sudo docker build -t dckreg:5000/kafka:$KAFKA_VERSION .
sudo docker push  dckreg:5000/kafka:$KAFKA_VERSION
