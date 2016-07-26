#!/bin/bash
# Setup script for debian/jessie base servers

# setup puppet repo
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb
sudo dpkg -i puppetlabs-release-pc1-jessie.deb

# install any updates
sudo apt-get update; sudo apt-get upgrade -y

# install puppet server
sudo apt-get install -y puppet-agent git rsync vim

sudo /opt/puppetlabs/bin/puppet agent --enable
sudo service puppet start

# puppet run
sudo /opt/puppetlabs/puppet/bin/puppet agent -t --server=puppetserver.vagrant.box
