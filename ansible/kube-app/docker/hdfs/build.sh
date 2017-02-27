#!/bin/bash

${HADOOP_VERSION?"Need to set HADOOP_VERSION"}
cat Dockerfile.template | sed -e "s/{{ HADOOP_VERSION }}/$HADOOP_VERSION/" > Dockerfile
sudo docker build -t dckreg:5000/hdfs:$HADOOP_VERSION .
sudo docker push  dckreg:5000/hdfs:$HADOOP_VERSION
