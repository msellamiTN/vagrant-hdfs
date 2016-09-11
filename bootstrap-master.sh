#!/usr/bin/env bash

. /vagrant/bootstrap-common.sh

apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

sudo -u vagrant ssh-keygen -t rsa -b 2048 -N "" -f /home/vagrant/.ssh/id_rsa
install -g vagrant -o vagrant -m0644 /dev/null  /home/vagrant/.ssh/known_hosts
ssh-keyscan hadoop-master >> /home/vagrant/.ssh/known_hosts
# Authorize ssh myself
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
# Copy same priv key for hadoop user
[ ! -d /home/hadoop/.ssh ] && install -g hadoop -o hadoop -d /home/hadoop/.ssh
cp /home/vagrant/.ssh/id_rsa* /home/hadoop/.ssh
chown hadoop:hadoop /home/hadoop/.ssh/id_rsa*
