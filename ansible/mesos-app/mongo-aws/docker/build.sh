#!/bin/bash

chmod 755 startmongo.sh
sudo docker build -t ${DOCKER_REGISTRY}/mongo:${TAG} .
sudo docker push ${DOCKER_REGISTRY}/mongo:${TAG}
