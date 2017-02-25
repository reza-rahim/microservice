#!/bin/bash

kubectl -s api:8080 create -f local-pv.yml

###
export PV_ANNOTATIONS=
export PV_ANNOTATIONS_LINE=

###
export ZK_REPLICAS=1
export ZK_LIST=zk-0.zk:2181
export ZK_DISK=1Gi

###
export KAFKA_VERSION=0.8.2.2 
export KAFKA_REPLICAS=1
export KAFKA_DISK=1Gi

###
export SPARK_VERSION=1.6.3
export SM_DISK=1Gi
export SW_REPLICAS=1
export SW_DISK=1Gi

###
export NN_DISK=1Gi
export DN_REPLICAS=1
export DN_DISK=1Gi

export DFS_REPLICATION=1

### 
export RS_REPLICAS=1

cat deploy/zk/zk.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ zk_replicas }}/$ZK_REPLICAS/" \
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
| kubectl -s api:8080 create -f -



