#!/bin/bash

sudo docker build -t dckreg:5000/mongo:2.6.12 .
sudo docker push dckreg:5000/mongo:2.6.12
