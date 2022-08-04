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

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get upgrade
    apt-get install -y curl vim valgrind gcc make python3-pip lldb build-essential git-core

    python3 -m pip install --upgrade pip setuptools
    python3 -m pip install norminette

    curl -sL https://raw.githubusercontent.com/pruiz-ca/42box/main/.42box_assets/bashrc -o /home/vagrant/.bashrc && chown vagrant:vagrant /home/vagrant/.bashrc
    curl -sL https://raw.githubusercontent.com/pruiz-ca/42box/main/.42box_assets/vimrc -o /home/vagrant/.vimrc && chown vagrant:vagrant /home/vagrant/.vimrc
    curl -sL https://raw.githubusercontent.com/pruiz-ca/42box/main/.42box_assets/vim/stdheader.vim --create-dirs -o /home/vagrant/.vim/stdheader.vim && chown -R vagrant:vagrant /home/vagrant/.vim
    curl -sL https://raw.githubusercontent.com/pruiz-ca/42box/main/.42box_assets/motd -o /etc/motd

    SHELL
end
