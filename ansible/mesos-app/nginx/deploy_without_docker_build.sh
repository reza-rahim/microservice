#!/bin/bash

#ssh docker volume create -d flocker -o size=10GB --name mongodb-01
export APP_GROUP=application/app
export APP_ID=nginx
export TAG=1.10.0
export INSTANCES=1
export CPUS=0.1
export MEMORY=128
export SLAVETYPE=system

cd ansible
ansible-playbook deploy.yml  -i "localhost," -e "memory=$MEMORY" -e "cpus=$CPUS" -e "instances=$INSTANCES" -e "app_group=$APP_GROUP" -e "app_id=$APP_ID" -e "tag=$TAG" -e "container_port=$CONTAINER_PORT" -e "service_port=$SERVICE_PORT" -e "slavetype=$SLAVETYPE" -e "marathon=$MARATHON" -e "docker_registry=$DOCKER_REGISTRY"
