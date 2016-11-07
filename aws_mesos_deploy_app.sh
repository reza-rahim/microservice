#!/bin/bash

if [ -z ${DOCKER_REGISTRY+x} ]; 
    then 
       echo "DOCKER_REGISTRY is env variable is not set";
       echo "Run: source /etc/bash.bashrc";
    exit 
fi

cd ansible/mesos-app/ubuntu
./build.sh

cd ../mongo-aws
./deploy_with_docker_build.sh
sleep 5

cd ../nodeapp
./deploy_with_docker_build.sh

sleep 5
cd ../nginx
./deploy_with_docker_build.sh
