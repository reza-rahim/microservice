 #!/bin/bash


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


cat deploy/hbase/hmstr.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
| kubectl -s api:8080 create -f -

