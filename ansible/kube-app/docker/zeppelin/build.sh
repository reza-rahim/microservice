#!/bin/bash

sudo docker build -t dckreg:5000/zeppelin:0.7.0 .
sudo docker push dckreg:5000/zeppelin:0.7.0 
