Hadoop hdfs on Vagrant machines
---
This project will run an [Hadoop Distributed FileSystem](https://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html) on a cluster of Virtual Machines. At the bottom some link that will explain a lot better than me the infrastructure that made this possible.    

This project needs so much work, I will appreciate all the criticism...

## Prerequisites
Install vagrant, virtualbox and vagrant hostmanager plugin
```
vagrant plugin install vagrant-hostmanager
```
## Startup the cluster
```
vagrant up
```

## Build the environment
```
vagrant ssh hadoop-master
cd /vagrant
ansible-playbook ansible-playbook.yml --ask-pass
# Insert password: vagrant
```
> The following manual steps will be removed in a future version and integrated in Ansible

## Startup Hadoop
On hadoop-master ( maybe can work wherever)
```
su - hadoop
cd /opt/hadoop
bin/hdfs namenode -format  # Only the first time
sbin/start-dfs.sh
sbin/start-yarn.sh
```
> The following step is optional, I usually install it only on master node

## Install fuse-hdfs
It allows you to write on the hdfs as if it were a normal file system.
```
# with root
wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb
dpkg -i cdh5-repository_1.0_all.deb
apt-get update
apt-get install hadoop-hdfs-fuse
hadoop-fuse-dfs dfs://hadoop-master:9000 /mnt
```

## Web interfaces
On Host system:
```
http://hadoop-master:50070
http://hadoop-master:50090
http://hadoop-master:8088
```
> Some info at: [Hadoop Default Ports Quick Reference](http://blog.cloudera.com/blog/2009/08/hadoop-default-ports-quick-reference/)

## Adding more nodes
Is straightforward, only change the number of slaves created in Vagrantfile here:
```
# Create as many slave as you wish...
(1..2).each do |i|
```
In the example it will be created 2 slaves. Ansible will take care of the rest... Nice!

## Shutting down the Cluster
On Host system:
```
vagrant destroy -f
```
It will shutdown and removes ALL the work you have done in the Virtual Machines, after issuing this command you will have to start over...

## References and thanks
- [Hadoop multinode Tutorial](http://www.tutorialspoint.com/hadoop/hadoop_multi_node_cluster.htm)
- [Vagrante and Ansible tutorial](https://sysadmincasts.com/episodes/45-learning-ansible-with-vagrant-part-2-4) -
*This was EPIC, this project was heavely based upon this tutorial*
- [Hadoop docs ](https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/ClusterSetup.html)
- [Vagrant](https://www.vagrantup.com/) - *Of course*
- [Virtualbox](https://www.virtualbox.org/) - *Pretty sure that this can work on another provisoner, but who cares...*
- [Fuse-hdfs](http://wiki.apache.org/hadoop/MountableHDFS)
