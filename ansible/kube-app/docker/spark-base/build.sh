#!/bin/bash

${HBASE_VERSION?"Need to set HBASE_VERSION"}
${SPARK_VERSION?"Need to set SPARK_VERSION"}
${SPARK_BIN_VERSION?"Need to set SPARK_BIN_VERSION"}
${SBT_VERSION?"Need to set SBT_VERSION"}

cat Dockerfile.template | \
sed -e "s/{{ SPARK_VERSION }}/$SPARK_VERSION/" \
    -e "s/{{ SPARK_BIN_VERSION }}/$SPARK_BIN_VERSION/" \
    -e "s/{{ PHOENIX_VERSION }}/$PHOENIX_VERSION/" \
    -e "s/{{ HBASE_VERSION }}/$HBASE_VERSION/" \
    -e "s/{{ SBT_VERSION }}/$SBT_VERSION/" \
> Dockerfile

sudo docker build -t dckreg:5000/spark-base:$SPARK_VERSION .
sudo docker push  dckreg:5000/spark-base:$SPARK_VERSION
