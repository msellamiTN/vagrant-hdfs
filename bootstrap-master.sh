#!/usr/bin/env bash

apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

sudo -u vagrant ssh-keygen -t rsa -b 2048 -N "" -f /home/vagrant/.ssh/id_rsa
install -g vagrant -o vagrant -m0644 /dev/null  /home/vagrant/.ssh/known_hosts
ssh-keyscan hadoop-master >> /home/vagrant/.ssh/known_hosts
# Authorize ssh myself
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

cat > /vagrant/inventory.ini << EOF
[master]
hadoop-master

[slave]
EOF

for f in $(sed -n '/vagrant-hostmanager-start/ {
         :next
         n; /vagrant-hostmanager-end/q; p; b next
       }' /etc/hosts | grep -v $(hostname) | awk '{print $2}') ; do
         if [[ $f == hadoop-slave* ]]; then
           echo "$f" >> /vagrant/inventory.ini
         fi
done
