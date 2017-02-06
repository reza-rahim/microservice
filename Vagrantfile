# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  # create mgmt node
  config.vm.define :mgmt do |mgmt_config|
      mgmt_config.vm.box = "bento/ubuntu-16.04"
      mgmt_config.vm.hostname = "mgmt"
      mgmt_config.vm.network :private_network, ip: "10.0.15.10"
      mgmt_config.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
      end
      mgmt_config.vm.provision :shell, path: "scripts/bootstrap-mgmt.ubuntu.sh"
  end
  
  # https://docs.vagrantup.com/v2/vagrantfile/tips.html
  (1..4).each do |i|
    config.vm.define "node#{i}" do |node|
        node.vm.box = "bento/ubuntu-16.04"
        node.vm.hostname = "node#{i}"
        node.vm.network :private_network, ip: "10.0.15.1#{i}"
        #node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "2048"
          vb.cpus = "4"
        end
        node.vm.provision :shell, path: "scripts/bootstrap-node.ubuntu.sh"
    end
  end
end
