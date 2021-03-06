#!/bin/bash
export aws_region=us-east-1
export aws_zone=us-east-1b
export cloud_provider=aws

cd ansible/provision

ansible-playbook install_pyhton.yml -i kube-aws-inventory.ini

ansible-playbook -i kube-aws-inventory.ini  kube-docker-registry.yml
./kube-docker.sh

ansible-playbook kube-cluster.yml -i kube-aws-inventory.ini -e cloud=aws

sleep 30

ansible-playbook kube-addon.yml -i kube-aws-inventory.ini

ansible-playbook haproxy.yml -i kube-aws-inventory.ini

