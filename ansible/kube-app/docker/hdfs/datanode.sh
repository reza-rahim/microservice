#!/bin/bash


chown -R hdfs /data
sudo -Eu hdfs $HADOOP_HOME/bin/hdfs datanode
