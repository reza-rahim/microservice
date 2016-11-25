#!/bin/bash
export TAG=0.6.1

sudo docker build -t $DOCKER_REGISTRY/zeppelin:${TAG} .
sudo docker push  $DOCKER_REGISTRY/zeppelin:${TAG} 
