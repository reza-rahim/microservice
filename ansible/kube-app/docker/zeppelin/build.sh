#!/bin/bash

${SPARK_VERSION?"Need to set SPARK_VERSION"}
${ZEPPELIN_VERSION?"Need to set ZEPPELIN_VERSION"}

cat Dockerfile.template | \
sed -e "s/{{ ZEPPELIN_VERSION }}/$ZEPPELIN_VERSION/" \
    -e "s/{{ SPARK_VERSION }}/$SPARK_VERSION/" \
> Dockerfile

sudo docker build -t dckreg:5000/zeppelin:$ZEPPELIN_VERSION .
sudo docker push dckreg:5000/zeppelin:$ZEPPELIN_VERSION 
