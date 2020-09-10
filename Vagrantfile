# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

   config.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.cpus = 4
     vb.memory = "8192"
   end

  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
