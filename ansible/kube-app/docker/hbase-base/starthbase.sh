#!/bin/bash

sed -i -e "s/{{ ZK_LIST }}/$ZK_LIST/"  $HBASE_HOME/conf/hbase-site.xml
sed  -i -e "s/{{ DFS_REPLICATION }}/$DFS_REPLICATION/" $HADOOP_HOME/etc/hadoop/hdfs-site.xml

HOST=$(hostname -f)

if [ $MODE = "master" ]; then
	sudo -Eu hdfs $HADOOP_HOME/bin/hdfs dfs  -mkdir  -p /user/hbase
        sudo -Eu hdfs $HADOOP_HOME/bin/hdfs dfs  -chown hbase /user/hbase
	sudo -Eu hbase $HBASE_HOME/bin/hbase  master start
else
        sed -i -e "s/{{ HOSTNAME }}/$HOST/"  $HBASE_HOME/conf/hbase-site.xml
	sudo -Eu hbase $HBASE_HOME/bin/hbase  regionserver start
fi 
