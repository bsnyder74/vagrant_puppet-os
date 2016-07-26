# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # hostmanager configs
  config.hostmanager.enabled = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  # boxes
    config.vm.define "puppetserver", primary: true do |puppet|
      config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      end
      puppet.vm.box = "centos/7"
      puppet.vm.hostname = "puppetserver.vagrant.box"
      puppet.hostmanager.aliases = %w(puppetserver)
      puppet.vm.network :private_network, ip: "192.168.250.120"
      puppet.vm.provision :shell, path: "scripts/bootstrap-el.sh"
      puppet.vm.network :forwarded_port, guest: 22, host: 2120, id: 'ssh'
    end

    config.vm.define "puppetdb" do |puppetdb|
      config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      end
      puppetdb.vm.box = "centos/7"
      puppetdb.vm.hostname = "puppetdb.vagrant.box"
      puppetdb.hostmanager.aliases = %w(puppetdb)
      puppetdb.vm.network :private_network, ip: "192.168.250.121"
      puppetdb.vm.provision :shell, path: "scripts/boot_pptdb.sh"
      puppetdb.vm.network :forwarded_port, guest: 22, host: 2121, id: 'ssh'
    end

    config.vm.define "web1" do |web1|
      config.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      end
      web1.vm.box = "centos/7"
      web1.vm.hostname = "web1.vagrant.box"
      web1.hostmanager.aliases = %w(web1)
      web1.vm.network :private_network, ip: "192.168.250.151"
      web1.vm.provision :shell, path: "scripts/boot_base.sh"
      web1.vm.network :forwarded_port, guest: 22, host: 2151, id: 'ssh'
    end

    config.vm.define "web2" do |web2|
      config.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      end
      web2.vm.box = "debian/jessie64"
      web2.vm.hostname = "web2.vagrant.box"
      web2.hostmanager.aliases = %w(web2)
      web2.vm.network :private_network, ip: "192.168.250.152"
      web2.vm.provision :shell, path: "scripts/boot_base_deb.sh"
      web2.vm.network :forwarded_port, guest: 22, host: 2152, id: 'ssh'
    end

    config.vm.define "db1" do |db1|
      config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      end
      db1.vm.box = "centos/7"
      db1.vm.hostname = "db1.vagrant.box"
      db1.hostmanager.aliases = %w(db1)
      db1.vm.network :private_network, ip: "192.168.250.161"
      db1.vm.provision :shell, path: "scripts/boot_base.sh"
      db1.vm.network :forwarded_port, guest: 22, host: 2161, id: 'ssh'
    end

    #
    # config.vm.define "dashboard" do |dashboard|
    #   dashboard.vm.hostname = "dashboard.vagrant.box"
    #   dashboard.vm.network :private_network, ip: "192.168.250.122"
    #   dashboard.vm.provision :shell, path: "scripts/boot_dash.sh"
    #   dashboard.vm.network :forwarded_port, guest: 22, host: 2122, id: 'ssh'
    # end
end
