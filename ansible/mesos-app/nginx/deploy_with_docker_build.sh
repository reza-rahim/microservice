#!/bin/bash

#ssh docker volume create -d flocker -o size=10GB --name mongodb-01
export APP_GROUP=application/app
export APP_ID=nginx
export TAG=1.10.0
export INSTANCES=1
export CPUS=0.1
export MEMORY=128
export SLAVETYPE=system

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
ansible-playbook deploy.yml  -i "localhost," -e "memory=$MEMORY" -e "cpus=$CPUS" -e "instances=$INSTANCES" -e "app_group=$APP_GROUP" -e "app_id=$APP_ID" -e "tag=$TAG" -e "container_port=$CONTAINER_PORT" -e "service_port=$SERVICE_PORT" -e "slavetype=$SLAVETYPE" -e "marathon=$MARATHON" -e "docker_registry=$DOCKER_REGISTRY"
