#!/bin/bash
# Setup script for base servers

# setup puppet repo
sudo yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# install puppet server
sudo yum install -y puppet-agent git rsync vim-enhanced

# add puppet servet to hosts
sudo echo "192.168.250.120 puppetserver.vagrant.box" >> /etc/hosts

# puppet run
sudo /opt/puppetlabs/puppet/bin/puppet agent -t --server=puppetserver.vagrant.box
