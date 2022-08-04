# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.hostname = "42box"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "42box"
    vb.gui = false
    vb.cpus = 1
    vb.memory = "1024"
   end

  config.vm.provision "file", source: ".42box_assets/bashrc", destination: "$HOME/.bashrc"
  config.vm.provision "file", source: ".42box_assets/vimrc", destination: "$HOME/.vimrc"
  config.vm.provision "file", source: ".42box_assets/vim", destination: "$HOME/.vim"
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get upgrade
    apt-get install -y curl vim valgrind gcc make python3-pip lldb build-essential git-core

    python3 -m pip install --upgrade pip setuptools
    python3 -m pip install norminette

    cp /vagrant/.42box_assets/motd /etc/motd

    SHELL
end
