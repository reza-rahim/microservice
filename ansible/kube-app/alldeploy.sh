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
export KAFKA_REPLICAS=1
export KAFKA_DISK=1Gi

###
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
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
    -e "s/{{ kafka_disk }}/$KAFKA_DISK/"  \
| kubectl -s api:8080 create -f -

cat deploy/spark/sprkmstr.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ sm_disk }}/$SM_DISK/"  \
| kubectl -s api:8080 create -f -


cat deploy/spark/sprkwrk.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ sw_replicas }}/$SW_REPLICAS/"  \
    -e "s/{{ sw_disk }}/$SW_DISK/"  \
| kubectl -s api:8080 create -f -

cat deploy/hdfs/nn.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ nn_disk }}/$NN_DISK/"  \
| kubectl -s api:8080 create -f -


cat deploy/hdfs/dn.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dn_replicas }}/$DN_REPLICAS/"  \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ dn_disk }}/$DN_DISK/"  \
| kubectl -s api:8080 create -f -

sleep 15

cat deploy/hbase/hmstr.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
| kubectl -s api:8080 create -f -

cat deploy/hbase/hrs.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ rs_replicas }}/$RS_REPLICAS/"  \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
| kubectl -s api:8080 create -f -
