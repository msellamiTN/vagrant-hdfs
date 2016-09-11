#!/usr/bin/env bash

# sudo apt-get install -y default-jre

useradd -m -p $(openssl passwd -1 hadoop) hadoop -s /bin/bash

cat > /etc/sudoers.d/hadoop << EOF
hadoop ALL=(ALL) NOPASSWD:ALL
EOF

cat >> /home/hadoop/.bashrc << EOF
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
EOF
