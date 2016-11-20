#!/bin/bash

if [ -z ${AWS_ACCESS_KEY_ID+x} ];
    then
       echo "AWS_ACCESS_KEY_ID is env variable is not set";
    exit
fi

if [ -z ${AWS_SECRET_ACCESS_KEY+x} ];
    then
       echo "AWS_SECRET_ACCESS_KEY is env variable is not set";
    exit
fi


ansible-playbook aws_cloud_formation.yml -i inventory.yml

./aws_createNatGatway.sh

ansible-playbook initialize_mgmt.yml --private-key pemfiles/sshKey.pem -i ec2.py -u ubuntu

