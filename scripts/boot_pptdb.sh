#!/bin/bash
# Setup script for PuppetDB server

# setup puppet repo
sudo yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# install any updates
sudo yum update -y

# install puppet server
sudo yum install -y puppet-agent git rsync vim-enhanced

# Firewall rules
# ADD 8081, 5432
fw_state=$(systemctl is-enabled firewalld)

if [ "$fw_state" = "disabled" ]; then
  sudo systemctl enable firewalld
  sudo systemctl start firewalld
else
  echo "firewalld service is already $fw_state."
fi

echo "adding firewall rules ..."
sudo firewall-cmd --zone=public --add-port=8081/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5432/tcp --permanent
sudo firewall-cmd --reload
