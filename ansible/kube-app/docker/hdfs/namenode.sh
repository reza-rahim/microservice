#!/bin/bash

sed  -i -e 's/nn-0.nn/0.0.0.0/' -e "s/{{ DFS_REPLICATION }}/$DFS_REPLICATION/" $HADOOP_HOME/etc/hadoop/hdfs-site.xml
sed  -i -e 's/nn-0.nn/0.0.0.0/' $HADOOP_HOME/etc/hadoop/core-site.xml

if [ ! -d /data/dfs/name ]; then
      mkdir -p /data/dfs/data /data/dfs/name /data/dfs/namesecondary
      hdfs namenode -format
fi

chown -R hdfs /data

sudo -Eu hdfs $HADOOP_HOME/bin/hdfs secondarynamenode &
sudo -Eu hdfs $HADOOP_HOME/bin/hdfs namenode
