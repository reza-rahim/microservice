#!/bin/bash

sed  -i -e "s/{{ DFS_REPLICATION }}/$DFS_REPLICATION/" $HADOOP_HOME/etc/hadoop/hdfs-site.xml

chown -R hdfs /data
sudo -Eu hdfs $HADOOP_HOME/bin/hdfs datanode
