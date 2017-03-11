 #!/bin/bash

cat deploy/mongo/mongo.yml | \
sed -e "s/{{ pv_annotations }}/$PV_ANNOTATIONS/" \
    -e "s/{{ pv_annotations_line }}/$PV_ANNOTATIONS_LINE/" \
    -e "s/{{ mongo_version }}/$MONGO_VERSION/" \
    -e "s/{{ mongo_disk }}/$MONGO_DISK/"  \
| kubectl -s api:8080 create -f -

kubectl -s api:8080 create -f deploy/nodeapp/nodeapp-svc.yml
kubectl -s api:8080 create -f deploy/nodeapp/nodeapp-1.1.yml --record

## release nodeapp:1.2 version 
## kubectl -s api:8080 set image deployment/nodeapp  nodeapp=dckreg:5000/nodeapp:1.2

## Role back
## kubectl -s api:8080 rollout history  deployments nodeapp
## kubectl -s api:8080 rollout undo deployments nodeapp --to-revision=1
## kubectl -s api:8080 rollout undo deployments nodeapp

##Scale up

## kubectl -s api:8080 scale  deployment/nodeapp --replicas=2
