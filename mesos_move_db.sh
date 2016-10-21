#!/bin/bash

ssh node3 sudo docker pull 10.0.15.11:5000/application/db/mongo:2.6.12

cd ansible/mesos-app/mongo
./deploy_without_docker_build.sh
