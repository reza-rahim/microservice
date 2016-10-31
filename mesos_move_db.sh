#!/bin/bash

ssh node3 sudo docker pull 10.0.15.11:5000/application/db/mongo:2.6.12

curl -X DELETE 10.0.15.11:8080/v2/apps/application/db/mongo
sleep 15


cd ansible/mesos-app/mongo
./deploy_without_docker_build.sh
