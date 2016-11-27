#!/bin/bash
export TAG=0.9.0.1

sudo docker build -t dckreg:5000/kafka:${TAG} .
sudo docker push  dckreg:5000/kafka:${TAG} 
