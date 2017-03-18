 #!/bin/bash

source docker/docker_version.conf
source conf/local_analytic_pod.conf

kubectl -s api:8080 create -f local-pv.yml


cat deploy/hdfs/nn.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ hadoop_version }}/$HADOOP_VERSION/"  \
    -e "s/{{ nn_disk }}/$NN_DISK/"  \
| kubectl -s api:8080 create -f -


sleep 5

cat deploy/hbase/hdfs-hrs.yml | \
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

cat deploy/hbase/hmstr.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ dfs_replication }}/$DFS_REPLICATION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
    -e "s/{{ hbase_version }}/$HBASE_VERSION/"  \
    -e "s/{{ zk_list }}/$ZK_LIST/"  \
| kubectl -s api:8080 create -f -
