# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "peru/ubuntu-18.04-desktop-amd64"
    config.vm.box_version = "20181101.01"
    config.vm.box_check_update = false
    config.vm.provider "virtualbox" do |vb|
        # Boot with headless mode
        vb.gui = false
        vb.name = "QA-Automation-Ubuntu-18.04-64bit"
        vb.memory = 4098
        # Turn on 3D Ac­cel­er­a­tion as a fix for some Windows hosts
        vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    end
    config.vm.provision "shell", path: "setup.sh", privileged: false
end
