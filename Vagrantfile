# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "nritholtz/ubuntu-14.04.1"
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
     vb.gui = false
     vb.name = "QA-Automation-Ubuntu-14.04-32bit"
  # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
   end
   config.vm.provision "shell", path: "setup.sh", privileged: false
end
