#!/bin/bash


cat deploy/zk/zk.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ zk_replicas }}/$ZK_REPLICAS/" \
    -e "s/{{ zookeeper_version }}/$ZOOKEEPER_VERSION/" \
    -e "s/{{ zk_disk }}/$ZK_DISK/"  \
| kubectl -s api:8080 create -f -

cat deploy/kafka/kafka.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ kafka_replicas }}/$KAFKA_REPLICAS/" \
    -e "s/{{ kafka_version }}/$KAFKA_VERSION/" \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
    -e "s/{{ kafka_disk }}/$KAFKA_DISK/"  \
| kubectl -s api:8080 create -f -

cat deploy/spark/sprkmstr.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ spark_version }}/$SPARK_VERSION/" \
    -e "s/{{ sm_disk }}/$SM_DISK/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
    -e "s/{{ kafka_broker_list }}/$KAFKA_BROKER_LIST/"  \
| kubectl -s api:8080 create -f -

cat deploy/spark/sprkwrk.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ spark_version }}/$SPARK_VERSION/" \
    -e "s/{{ sw_replicas }}/$SW_REPLICAS/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
    -e "s/{{ kafka_broker_list }}/$KAFKA_BROKER_LIST/"  \
    -e "s/{{ sw_disk }}/$SW_DISK/"  \
| kubectl -s api:8080 create -f -



cat deploy/hdfs/nn.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ hadoop_version }}/$HADOOP_VERSION/"  \
    -e "s/{{ nn_disk }}/$NN_DISK/"  \
| kubectl -s api:8080 create -f -


cat deploy/hdfs/dn.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dn_replicas }}/$DN_REPLICAS/"  \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ dn_disk }}/$DN_DISK/"  \
    -e "s/{{ hadoop_version }}/$HADOOP_VERSION/"  \
    -e "s/{{ hbase_version }}/$HBASE_VERSION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
| kubectl -s api:8080 create -f -

sleep 15

cat deploy/hbase/hrs.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ rs_replicas }}/$RS_REPLICAS/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
    -e "s/{{ hbase_version }}/$HBASE_VERSION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
| kubectl -s api:8080 create -f -

sleep 15

cat deploy/hbase/hmstr.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
    -e "s/{{ hbase_version }}/$HBASE_VERSION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
| kubectl -s api:8080 create -f -

