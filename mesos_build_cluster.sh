#!/bin/bash

cd ansible/provision
ansible-playbook mesos_build_cluster.yml -i inventory.ini
sleep 30
ansible-playbook mesos_system_services.yml -i inventory.ini
