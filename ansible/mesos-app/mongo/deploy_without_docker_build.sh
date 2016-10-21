#!/bin/bash

export APP_GROUP=application/db
export APP_ID=mongo
export TAG=2.6.12
export INSTANCES=1
export CPUS=0.1
export MEMORY=128
export DB_SIZE=1GB
export SLAVETYPE=app
export DB_SERVER=10.0.15.13

cd ansible
ansible-playbook deploy.yml -e "memory=$MEMORY" -e "cpus=$CPUS" -e "instances=$INSTANCES" -e "app_group=$APP_GROUP" -e "app_id=$APP_ID" -e "tag=$TAG" -e "db_size=$DB_SIZE" -e "slavetype=$SLAVETYPE" -e "db_server=$DB_SERVER"
