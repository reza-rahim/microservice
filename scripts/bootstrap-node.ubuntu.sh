#!/usr/bin/env bash

sudo apt-get -y update
sudo apt-get -y install zfsutils-linux

mkdir -p /var/opt/flocker
truncate --size 10GB /var/opt/flocker/pool-vdev
zpool create flocker /var/opt/flocker/pool-vdev
####zpool destroy flocker 
####rm -rf /flocker/


cat  /vagrant/scripts/authorized_keys >> /home/vagrant/.ssh/authorized_keys

sudo mkdir /root/.ssh
cat  /vagrant/scripts/authorized_keys >> /root/.ssh/authorized_keys

cat >> /root/.ssh/config <<EOL
Host *
  StrictHostKeyChecking no
EOL

# configure hosts file for our internal network defined by Vagrantfile
cat > /etc/hosts <<EOL

# vagrant environment nodes
127.0.0.1   localhost
10.0.15.10  mgmt  dckreg
10.0.15.11  node1 api
10.0.15.12  node2
10.0.15.13  node3
10.0.15.14  node4
10.0.15.15  node5
10.0.15.16  node6
10.0.15.17  node7
EOL
