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
## Startup Hadoop
On hadoop-master ( maybe can work wherever)
```
su - hadoop
cd /opt/hadoop
bin/hdfs namenode -format  # Only the first time
sbin/start-dfs.sh
sbin/start-yarn.sh
```

## Install fuse-hdfs
```
wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb
dpkg -i cdh5-repository_1.0_all.deb
apt-get update
apt-get install hadoop-hdfs-fuse
hadoop-fuse-dfs dfs://hadoop-master:9000 /mnt
```
