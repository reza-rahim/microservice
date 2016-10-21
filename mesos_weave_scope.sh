#!/bin/bash

cd ansible/provision/
ansible-playbook mesos_start_cluster.yml --tag "scope"
