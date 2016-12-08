#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
sudo apt-get update
#sudo apt-get -y install software-properties-common
#sudo apt-add-repository -y ppa:ansible/ansible
#sudo apt-get -y install ansible

sudo apt-get -y install python-pip python-dev
sudo pip  install ansible==1.9.3
sudo pip  install httplib2==0.7.7
sudo mkdir /etc/ansible/

sudo apt-get -y install git
sudo git config --global user.name "Reza Rahim"

# copy examples into /home/vagrant (from inside the mgmt node)
cp -a /vagrant/ansible/ /home/vagrant/ansible
chown -R vagrant:vagrant /home/vagrant

cp -a /vagrant/mesos* /home/vagrant/

chmod 755  /home/vagrant/*.sh

chown -R vagrant:vagrant /home/vagrant

cp -a /vagrant/scripts/id_rsa /home/vagrant/.ssh/id_rsa
cat  /vagrant/scripts/authorized_keys >> /home/vagrant/.ssh/authorized_keys

chown -R vagrant:vagrant /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa

chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys

cat >> /home/vagrant/.ssh/config <<EOL
Host *
  StrictHostKeyChecking no
EOL

cp -a ansible/inventory.ini /etc/ansible/hosts

# configure hosts file for our internal network defined by Vagrantfile
cat > /etc/hosts <<EOL

# vagrant environment nodes
127.0.0.1  localhost
10.0.15.10 mgmt hdfscli1 sparkcli1 hbasecli1 kafkacli1
10.0.15.11 node1 zk1 nn1 sm1 zep1 hmst1 dckreg  mrthn
10.0.15.12  node2 dn01 sw01 hrs01 kaf01
10.0.15.13  node3 dn02 sw02 hrs02 kaf02
10.0.15.14  node4 dn03 sw03 hrs03 kaf03
10.0.15.15  node5 dn04 sw04 hrs04 kaf04
10.0.15.16  node6 dn05 sw05 hrs05 kaf05
10.0.15.17  node7 dn06 sw06 hrs06 kaf06
EOL
