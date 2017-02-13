#!/bin/bash

sudo docker build -t dckreg:5000/nodeapp:1.1 .
sudo docker push dckreg:5000/nodeapp:1.1
