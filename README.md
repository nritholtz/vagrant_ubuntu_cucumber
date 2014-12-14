vagrant_ubuntu_cucumber
=======================

A vagrant VM stack for automated testing that has pre-installed RVM/Oracle/QT to be used in conjuction with Rails/Capybara/Cucumber/Capyara-Webkit 

------------------------------------------

###Requirements
Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads): Download both the platform package for your OS and Oracle VM VirtualBox Extension Pack

Install [Vagrant](https://www.vagrantup.com/downloads.html): Vagrant version must be >= 2



###Using The Template
1) Clone this repo from command line/terminal `git clone https://github.com/nritholtz/vagrant_ubuntu_cucumber.git`

2) Change directory to this newly cloned directory and run `vagrant up` 

3) Since this will provision your box, it may take some time depending on your computer's resources. Keep a watch on the command line for when it says `Done!`

4) Open up VirtualBox and start up the box with the name starting with`QA-Automation-Ubuntu`.


###Information
1) Username and password is both vagrant

2) The vagrant user has passwordless sudo rights

3) A placeholder tnsnames.ora was created in /opt/oracle/instantclient_12_1/network/admin. Replace or update the file with your own TNS entries.

4) By default, the machine will also install Ruby 2.1.2, Oracle Instant Client 12.1, and QT 5

5) All of the setup logging ouput is located in your new machine's /home/vagrant/setup.log file

6) Added an alias `cukes` that will run as `bundle exec cucumber`


###After Installation
1) You should create your own [SSH-key](https://help.github.com/articles/generating-ssh-keys/) for integration with Github and other SSH-enabled applications

2) Install your own Text Editor for use with your applications. I highly recommend [Sublime Text 3](http://www.sublimetext.com/3). Another recommended open-source choice is [Atom](https://atom.io)