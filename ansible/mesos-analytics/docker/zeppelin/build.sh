#!/bin/bash
export TAG=0.6.1

sudo docker build -t dckreg:5000/zeppelin:${TAG} .
sudo docker push dckreg:5000/zeppelin:${TAG} 
