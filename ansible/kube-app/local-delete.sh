 #!/bin/bash
###

kubectl -s api:8080 delete StatefulSet zk
kubectl -s api:8080 delete svc zk

kubectl -s api:8080 delete StatefulSet kafka
kubectl -s api:8080 delete svc kafka

kubectl -s api:8080 delete StatefulSet sm
kubectl -s api:8080 delete svc sm

kubectl -s api:8080 delete StatefulSet sw
kubectl -s api:8080 delete svc sw

kubectl -s api:8080 delete StatefulSet nn
kubectl -s api:8080 delete svc nn

kubectl -s api:8080 delete StatefulSet dn
kubectl -s api:8080 delete svc dn

kubectl -s api:8080 delete StatefulSet hm
kubectl -s api:8080 delete svc hm

kubectl -s api:8080 delete StatefulSet rs
kubectl -s api:8080 delete svc rs

kubectl -s api:8080 delete pvc  datadir-zk-0
kubectl -s api:8080 delete pvc  datadir-kafka-0
kubectl -s api:8080 delete pvc  datadir-sm-0
kubectl -s api:8080 delete pvc  datadir-sw-0
kubectl -s api:8080 delete pvc  datadir-nn-0
kubectl -s api:8080 delete pvc  datadir-dn-0

kubectl -s api:8080 delete pv  local-0
kubectl -s api:8080 delete pv  local-1
kubectl -s api:8080 delete pv  local-2
kubectl -s api:8080 delete pv  local-3
kubectl -s api:8080 delete pv  local-4
kubectl -s api:8080 delete pv  local-5
kubectl -s api:8080 delete pv  local-6

ssh node1 sudo rm -rf /tmp/local*
ssh node2 sudo rm -rf /tmp/local*
ssh node3 sudo rm -rf /tmp/local*
