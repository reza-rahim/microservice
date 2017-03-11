#!/bin/bash

source docker/docker_version.conf
source conf/analytic_pod.conf


cat deploy/spark-cli/smcli.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ spark_version }}/$SPARK_VERSION/" \
    -e "s/{{ sm_disk }}/$SM_DISK/"  \
| kubectl -s api:8080 create -f -

