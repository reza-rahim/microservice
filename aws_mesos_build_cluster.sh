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

export aws_region=us-east-1
export aws_zone=us-east-1b
export cloud_provider=aws

cd ansible/provision

ansible-playbook install_pyhton.yml -i inventory.ini

ansible-playbook mesos_build_cluster.yml -i inventory.ini -e "cloud_provider=$cloud_provider" -e "aws_region=$aws_region" -e "aws_zone=$aws_zone" -e "aws_access_key_id=$AWS_ACCESS_KEY_ID" -e "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY"

sleep 30

ansible-playbook mesos_system_services.yml -i inventory.ini
