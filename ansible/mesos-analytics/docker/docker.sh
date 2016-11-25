#!/bin/bash

cd hdfs-base
./build.sh
cd ../hdfs-nn
./build.sh
cd ../hdfs-dn
./build.sh
cd ../spark-base
./build.sh
cd ../spark-master
./build.sh
cd ../spark-worker
./build.sh
cd ../zeppelin
./build.sh
