## Prerequisites
Install vagrant hostmanager plugin:
vagrant plugin install vagrant-hostmanager

## Build the environment
```
vagrant ssh hadoop-master
cd /vagrant
ansible-playbook ansible-playbook.yml --ask-pass
# Insert password: vagrant
```
