#!/bin/bash
sudo docker build -t dckreg:5000/kafka:0.10.0.1 .
sudo docker push  dckreg:5000/kafka:0.10.0.1
