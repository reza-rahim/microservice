#!/bin/bash
sudo docker build -t dckreg:5000/kafka:0.8.2.2 .
sudo docker push  dckreg:5000/kafka:0.8.2.2
