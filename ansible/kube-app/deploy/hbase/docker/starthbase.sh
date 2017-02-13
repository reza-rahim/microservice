#!/bin/bash

cat hbase-site.xml.template | sed "s/{{ZK}}/$ZK/g"  > $HBASE_HOME/conf/hbase-site.xml

if [ $MODE = "master" ]; then
	hbase master start
else
	hbase regionserver start
fi 
