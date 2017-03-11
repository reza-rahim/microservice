 #!/bin/bash

kubectl -s api:8080 create -f local-pv.yml

source docker/docker_version.conf
source conf/pods.conf

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
| kubectl -s api:8080 create -f -


