#!/bin/bash

source conf/aws_analytic_pod.conf

cat deploy/noderest/noderest-dep.yml |  \
sed -e "s/{{ kafka_broker_list }}/$KAFKA_BROKER_LIST/" \
| kubectl -s api:8080 create -f -

cat deploy/noderest/noderest-svc.yml \
| kubectl -s api:8080 create -f -
