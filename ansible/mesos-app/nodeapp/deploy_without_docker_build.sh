#!/bin/bash

source current_tag.sh

export APP_GROUP=application/app
export APP_ID=nodeapp
export INSTANCES=3
export CPUS=0.1
export MEMORY=128
export SLAVETYPE=app


### deploy the app to marathon

cd ansible

ansible-playbook deploy.yml  -i "localhost," -e "memory=$MEMORY" -e "cpus=$CPUS" -e "instances=$INSTANCES" -e "app_group=$APP_GROUP" -e "app_id=$APP_ID" -e "tag=$TAG" -e "container_port=$CONTAINER_PORT" -e "service_port=$SERVICE_PORT" -e "slavetype=$SLAVETYPE" -e "marathon=$MARATHON" -e "docker_registry=$DOCKER_REGISTRY"
