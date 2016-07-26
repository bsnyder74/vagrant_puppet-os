#!/bin/bash
# Setup script for base servers

# setup puppet repo
sudo yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# install any updates
sudo yum update -y

# install puppet server
sudo yum install -y puppet-agent git rsync vim-enhanced

# puppet run
sudo /opt/puppetlabs/puppet/bin/puppet agent -t --server=puppetserver.vagrant.box
