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
10.0.15.10  mgmt hdfscli1 sparkcli1 hbasecli1 kafkacli1
10.0.15.11  node1 zk1 nn1 sm1 zep1 hmst1 dckreg mrthn 
10.0.15.12  node2 dn01 sw01 hrs01 kaf01
10.0.15.13  node3 dn02 sw02 hrs02 kaf02
10.0.15.14  node4 dn03 sw03 hrs03 kaf03
10.0.15.15  node5 dn04 sw04 hrs04 kaf04
10.0.15.16  node6 dn05 sw05 hrs05 kaf05
10.0.15.17  node7 dn06 sw06 hrs06 kaf06
EOL
