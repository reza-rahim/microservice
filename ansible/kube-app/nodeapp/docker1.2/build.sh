#!/bin/bash

sudo docker build -t dckreg:5000/nodeapp:1.2 .
sudo docker push dckreg:5000/nodeapp:1.2
