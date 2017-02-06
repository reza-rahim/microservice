#!/bin/bash

if [ $MODE = "master" ]; then
   start-master.sh
else
   start-slave.sh $SPARK_MASTER_IP:7077
fi
