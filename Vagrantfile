# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  # config.vm.synced_folder "./data", "/data", create: true

  config.vm.define "twui" do |twui|
    #twui.vm.box = "twui"
    twui.vm.hostname = 'twui'
    twui.vm.network :private_network, ip: "192.168.56.101"
    twui.vm.network "forwarded_port", guest: 8080, host: 8081
    # For the flask app...
    twui.vm.network "forwarded_port", guest: 5000, host: 5000

    twui.vm.provider :virtualbox do |v|
      v.name = "twui"
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "twui"]
    end
    twui.vm.provision "shell", inline: "mkdir ~/data"
    twui.vm.provision :file, source: './data', destination: '~/data'
    twui.vm.provision :file, source: '~/.sandbox.conf.sh', destination: '~/.sandbox.conf.sh'
    twui.vm.provision "shell", path: "./setup_twui.sh", privileged: false
  end

  config.vm.define "twws" do |twws|
    #twws.vm.box = "precise64"
    twws.vm.hostname = 'twws'

    twws.vm.network :private_network, ip: "192.168.56.102"
    twws.vm.network "forwarded_port", guest: 8080, host: 8082

    twws.vm.provider :virtualbox do |v|
      v.name = "twws"
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "twws"]
    end
    twws.vm.provision "shell", inline: "mkdir ~/data"
    twws.vm.provision :file, source: './data', destination: '~/data'
    twws.vm.provision :file, source: '~/.sandbox.conf.sh', destination: '~/.sandbox.conf.sh'
    twws.vm.provision "shell", path: "./setup_twws.sh", privileged: false
  end

  config.vm.define "twdb" do |twdb|
    #twdb.vm.box = "precise64"
    twdb.vm.hostname = 'twdb'

    twdb.vm.network :private_network, ip: "192.168.56.103"
    twdb.vm.network "forwarded_port", guest: 5432, host: 5432

    twdb.vm.provider :virtualbox do |v|
      v.name = "twdb"
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "twdb"]
    end
    twdb.vm.provision "shell", inline: "mkdir ~/data"
    twdb.vm.provision :file, source: './data', destination: '~/data'
    twdb.vm.provision :file, source: '~/.sandbox.conf.sh', destination: '~/.sandbox.conf.sh'
    twdb.vm.provision "shell", path: "./setup_twdb.sh", privileged: false
  end

end
