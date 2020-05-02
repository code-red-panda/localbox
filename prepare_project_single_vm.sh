#!/bin/bash

PROJECT=$1
IP=$2

if test -z $PROJECT
then
    echo "Not enough arguments provided."
    exit 1
elif test -z $IP
then
    echo "Not enough arguments provided."
    exit 1
fi

mkdir -p $PROJECT

#########################
### Generate vagrantfile
#########################

echo 'Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|

    # Hardware
    vb.memory = 512
    vb.cpus = 1
    vb.linked_clone = true

  end

  # VM
  config.vm.define "vm", primary: true do |node|

    # OS
    node.vm.box = "centos/7"
    node.vm.box_version = "1905.1"
    node.vm.box_check_update = false

    # Network
    node.vm.hostname = "'$PROJECT'"
    node.vm.network "private_network", ip: "192.168.2.'$IP'"
    node.hostmanager.enabled = true
    node.hostmanager.manage_guest = true
    node.hostmanager.ignore_private_ip = false

  end

end' > $PROJECT/vagrantfile