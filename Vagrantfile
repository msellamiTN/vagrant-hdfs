# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  # create hadoop-master
  config.vm.define "hadoop-master" do |master_config|
      master_config.vm.box = "ubuntu/trusty64"
      master_config.vm.hostname = "hadoop-master"
      master_config.vm.network :private_network, ip: "10.0.4.10"
      master_config.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        # vb.gui = true
      end
      master_config.vm.provision :shell, path: "bootstrap-master.sh"
  end


  # create some web servers
  # https://docs.vagrantup.com/v2/vagrantfile/tips.html
  (1..1).each do |i|
    config.vm.define "hadoop-slave-#{i}" do |node|
        node.vm.box = "ubuntu/trusty64"
        node.vm.hostname = "hadoop-slave-#{i}"
        node.vm.network :private_network, ip: "10.0.4.2#{i}"
        # node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "256"
          # vb.gui = true
        end
        node.vm.provision :shell, path: "bootstrap-slave.sh"
    end
  end

end
