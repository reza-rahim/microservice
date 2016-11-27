#!/bin/bash

cd ansible/provision
ansible-playbook analytics_mesos_build_cluster.yml -i analytics_inventory.ini
sleep 30
ansible-playbook mesos_system_services.yml -i inventory.ini
