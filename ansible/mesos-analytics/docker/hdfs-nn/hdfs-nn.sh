#!/bin/bash

if [ ! -d /data/dfs/name ]; then
        mkdir -p /data/dfs/data /data/dfs/name /data/dfs/namesecondary
        hdfs namenode -format
fi

hdfs namenode
