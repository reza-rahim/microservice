#!/bin/bash

cd ./docker
./build.sh

cd ..

kubectl -s node1:8080 create  -f kube-dep.yaml
kubectl -s node1:8080 expose deployment/mongo-deployment
