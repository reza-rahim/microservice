#!/bin/bash

cd ansible/provision
ansible-playbook install_pyhton.yml -i inventory.ini
