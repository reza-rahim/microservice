#!/bin/bash

#ssh docker volume create -d flocker -o size=10GB --name mongodb-01
export APP_GROUP=application/db
export APP_ID=mongo
export TAG=2.6.12
export INSTANCES=1
export CPUS=0.1
export MEMORY=128
export DB_SIZE=1GB
export SLAVETYPE=app
export DB_SERVER=10.0.15.12

cd docker

### create docker images
sudo docker build -t $DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$TAG .

if [ "$?" != "0" ]; then
    echo "Failed : docker build -t $DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$TAG ."
    exit 1
fi

#### push the image  to docker registry
sudo docker push $DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$TAG

if [ "$?" != "0" ]; then
    echo "Failed : docker push $DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$TAG"
    exit 1
fi


### deploy the app to marathon

cd ..
cd ansible
ansible-playbook deploy.yml  -i "localhost," -e "memory=$MEMORY" -e "cpus=$CPUS" -e "instances=$INSTANCES" -e "app_group=$APP_GROUP" -e "app_id=$APP_ID" -e "tag=$TAG" -e "db_size=$DB_SIZE" -e "slavetype=$SLAVETYPE" -e "db_server=$DB_SERVER"  -e "marathon=$MARATHON" -e "docker_registry=$DOCKER_REGISTRY"
