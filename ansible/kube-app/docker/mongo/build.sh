#!/bin/bash

${MONGO_VERSION?"Need to set MONGO_VERSION"}
cat Dockerfile.template | sed -e "s/{{ MONGO_VERSION }}/$MONGO_VERSION/" > Dockerfile

sudo docker build -t dckreg:5000/mongo:$MONGO_VERSION .
sudo docker push dckreg:5000/mongo:$MONGO_VERSION
