#!/bin/bash


if [ $MODE = "nn" ]; then
   if [ ! -d /data/dfs/name ]; then
        mkdir -p /data/dfs/data /data/dfs/name /data/dfs/namesecondary
        hdfs namenode -format
   fi
   cat core-site.xml.template |  sed "s/{{NN_IP}}/$NN_IP/g" > $HADOOP_HOME/etc/hadoop/core-site.xml
   cat hdfs-site.xml.template |  sed "s/{{NN_IP}}/$NN_IP/g" > $HADOOP_HOME/etc/hadoop/hdfs-site.xml
   hdfs secondarynamenode &
   hdfs namenode
else
   hdfs datanode
fi
