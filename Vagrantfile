# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos7"
  config.vm.box_url = "https://f0fff3908f081cb6461b407be80daf97f07ac418.googledrive.com/host/0BwtuV7VyVTSkUG1PM3pCeDJ4dVE/centos7.box"
  config.vm.provision "shell", path: "Vagrant-provision-file.sh"

  config.vm.define "tom" do |tom|
    tom.vm.hostname = "tom"
    tom.vm.network :private_network, ip: "10.0.0.5", :netmask => "255.255.255.0"
  end

  config.vm.define "jerry" do |jerry|
    jerry.vm.hostname = "jerry"
    jerry.vm.network :private_network, ip: "10.0.0.6", :netmask => "255.255.255.0"
  end
end
