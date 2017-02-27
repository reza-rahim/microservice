#!/bin/bash

${ZOOKEEPER_VERSION?"Need to set ZOOKEEPER_VERSION"}

cat Dockerfile.template | \
sed -e "s/{{ ZOOKEEPER_VERSION }}/$ZOOKEEPER_VERSION/" \
> Dockerfile

sudo docker build -t dckreg:5000/zookeeper:$ZOOKEEPER_VERSION .
sudo docker push  dckreg:5000/zookeeper:$ZOOKEEPER_VERSION
