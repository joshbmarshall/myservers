# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/centos-6.6"

  config.vm.network "public_network"

  config.vm.provision "shell",
    path: "dochef.sh",
    keep_color: true

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
  end

end
