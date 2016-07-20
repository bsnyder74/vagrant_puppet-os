#!/bin/bash

# setup puppet repo
sudo yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# install puppet server
sudo yum install -y puppetserver puppet-agent git rsync vim-enhanced tree

# Firewall rules
# ADD 8140
fw_state=$(systemctl is-enabled firewalld)

if [ "$fw_state" = "disabled" ]; then
  sudo systemctl enable firewalld
  sudo systemctl start firewalld
else
  echo "firewalld service is already $fw_state."
fi

echo "adding firewall rules ..."
sudo firewall-cmd --zone=public --add-port=8140/tcp --permanent
sudo firewall-cmd --reload

# Add master to hosts file
echo "updating /etc/hosts ..."
echo "192.168.250.120 puppetserver.vagrant.box" >> /etc/hosts

# Limit memory usage
echo "limiting java memory usage for puppet ..."
sudo sed -i 's/JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m"/# JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m"/' /etc/sysconfig/puppetserver
sudo sed -i '10i JAVA_ARGS="-Xms512m -Xmx512m"' /etc/sysconfig/puppetserver

# Installing hiera-eyaml
echo "installing hiera-eyaml ..."
sudo /opt/puppetlabs/bin/puppetserver gem install hiera-eyaml --no-ri --no-rdoc

# Setup r10k
echo "installing r10k ..."
sudo mkdir /var/cache/r10k
sudo chown vagrant /var/cache/r10k
sudo /opt/puppetlabs/puppet/bin/gem install r10k --no-ri --no-rdoc
sudo mkdir /etc/puppetlabs/r10k
sudo cp /home/vagrant/sync/scripts/r10k.yaml /etc/puppetlabs/r10k/
sudo /opt/puppetlabs/puppet/bin/r10k deploy environment -pv

# Congigure greeting
cat > /etc/motd<<END
#############################
# puppetserver.vagrant.box  #
#############################
END

# Wrap-up
ppconf='/etc/puppetlabs/puppet/puppet.conf'

if [ -a $ppconf ]; then
  sudo systemctl enable puppetserver
  sudo systemctl start puppetserver
  echo "Puppet is installed and ready."
else
  echo "Puppet may not be installed properly ..."
fi
