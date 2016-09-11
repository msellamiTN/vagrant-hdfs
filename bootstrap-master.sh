#!/usr/bin/env bash

. /vagrant/bootstrap-common.sh

apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

sudo -u vagrant ssh-keygen -t rsa -b 2048 -N "" -f /home/vagrant/.ssh/id_rsa
[ ! -d /home/hadoop/.ssh ] && mkdir /home/hadoop/.ssh && chown hadoop:hadoop /home/hadoop/.ssh 
cp /home/vagrant/.ssh/id_rsa* /home/hadoop/.ssh
chown hadoop:hadoop /home/hadoop/.ssh/id_rsa*
