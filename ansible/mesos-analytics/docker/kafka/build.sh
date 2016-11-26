#!/bin/bash
export TAG=0.9.0.1

sudo docker build -t $DOCKER_REGISTRY/kafka:${TAG} .
sudo docker push  $DOCKER_REGISTRY/kafka:${TAG} 
