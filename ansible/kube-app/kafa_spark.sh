#!/bin/bash

kubectl -s api:8080 create -f local-pv.yml

source docker/docker_version.conf
source conf/pods.conf

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
| kubectl -s api:8080 create -f -

cat deploy/spark/sprkwrk.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ spark_version }}/$SPARK_VERSION/" \
    -e "s/{{ sw_replicas }}/$SW_REPLICAS/"  \
    -e "s/{{ sw_disk }}/$SW_DISK/"  \
| kubectl -s api:8080 create -f -

