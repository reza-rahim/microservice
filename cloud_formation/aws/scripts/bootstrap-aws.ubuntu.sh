#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
sudo apt-get update
sudo apt-get -y install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -y install ansible

sudo apt-get -y install python-pip python-dev
#sudo pip  install ansible==1.9.3
#sudo pip  install httplib2==0.7.7

sudo pip install -U boto

sudo apt-get -y install git
sudo git config --global user.name "Reza Rahim"

sudo apt -y install jq

sudo apt -y install awscli

cat >> /home/vagrant/.ssh/config <<EOL
Host *
  StrictHostKeyChecking no
  ForwardAgent yes
EOL
