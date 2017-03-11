#!/bin/bash

source docker_version.conf

ssh dckreg mkdir -p /var/tmp/java
scp java/* dckreg:/var/tmp/java
ssh dckreg "cd /var/tmp/java;./build.sh"

ssh dckreg mkdir -p /var/tmp/node-rest
scp -r noderest/* dckreg:/var/tmp/node-rest
ssh dckreg "cd /var/tmp/node-rest/;./build.sh"

ssh dckreg mkdir -p /var/tmp/zk
scp zk/* dckreg:/var/tmp/zk
ssh dckreg "export ZOOKEEPER_VERSION=$ZOOKEEPER_VERSION;cd /var/tmp/zk;./build.sh"

ssh dckreg mkdir -p /var/tmp/hdfs
scp hdfs/* dckreg:/var/tmp/hdfs
ssh dckreg "export HADOOP_VERSION=$HADOOP_VERSION;cd /var/tmp/hdfs;./build.sh"

ssh dckreg mkdir -p /var/tmp/hbase
scp hbase/* dckreg:/var/tmp/hbase
ssh dckreg "export HADOOP_VERSION=$HADOOP_VERSION; export HBASE_VERSION=$HBASE_VERSION;export PHOENIX_VERSION=$PHOENIX_VERSION;cd /var/tmp/hbase;./build.sh"

ssh dckreg mkdir -p /var/tmp/kafka
scp kafka/* dckreg:/var/tmp/kafka
ssh dckreg "export KAFKA_SCALA_VERSION=$KAFKA_SCALA_VERSION; export KAFKA_VERSION=$KAFKA_VERSION;cd /var/tmp/kafka;./build.sh"

ssh dckreg mkdir -p /var/tmp/spark
scp spark/* dckreg:/var/tmp/spark
ssh dckreg "export HBASE_VERSION=$HBASE_VERSION; export SPARK_VERSION=$SPARK_VERSION; export SPARK_BIN_VERSION=$SPARK_BIN_VERSION; export SBT_VERSION=$SBT_VERSION; cd /var/tmp/spark;./build.sh"

ssh dckreg mkdir -p /var/tmp/zeppelin
scp zeppelin/* dckreg:/var/tmp/zeppelin
ssh dckreg "export SPARK_VERSION=$SPARK_VERSION; export ZEPPELIN_VERSION=$ZEPPELIN_VERSION;cd /var/tmp/zeppelin;./build.sh"

