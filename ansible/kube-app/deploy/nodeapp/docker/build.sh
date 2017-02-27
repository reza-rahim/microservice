#!/bin/bash

sudo docker build -t dckreg:5000/nodeapp .
sudo docker push dckreg:5000/nodeapp
