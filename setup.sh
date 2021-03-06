DownloadFile () {
  local url=$1
  echo -n "    "
  #sudo wget $1 -O $2
   sudo wget --progress=dot $url -O $2 2>&1 | grep --line-buffered "%" | \
      sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
  echo -ne "\b\b\b\b"
  echo "Download Complete"
}
AddConfig () {
  echo $1 >> /home/vagrant/.bashrc
}
Log(){
  blue='\033[1;34m'
  NC='\033[0m'
  echo -e "${blue}####$1####${NC}"
}

#######################
##Oracle Installation##
#######################
Log 'Starting Oracle Instant Client Installation'
#Import Oracle Instant Client components and unzip them
sudo mkdir /opt/oracle
cd /opt/oracle

#Since Oracle requires authentication when downloading file, I am hosting the files on Dropbox to be able to wget
DownloadFile https://www.dropbox.com/s/r7sxlrn1tnayqt8/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip?dl=0 instantclient-sqlplus-linux-12.1.0.2.0.zip
DownloadFile https://www.dropbox.com/s/6wgmopzndyd7j90/instantclient-sdk-linux.x64-12.1.0.2.0.zip?dl=0 instantclient-sdk-linux-12.1.0.2.0.zip
DownloadFile https://www.dropbox.com/s/zcatpxmgdnugykg/instantclient-basic-linux.x64-12.1.0.2.0.zip?dl=0 instantclient-basic-linux-12.1.0.2.0.zip
sudo unzip \*.zip >>/home/vagrant/setup.log 2>&1
sudo rm -rf instant*.zip
cd instantclient_12_1
sudo ln -s libclntsh.so.12.1 libclntsh.so 

#Add tnsname.ora placeholder
sudo mkdir network
sudo mkdir network/admin
sudo touch network/admin/tnsnames.ora

#Add environment variables
AddConfig 'export LD_LIBRARY_PATH="/opt/oracle/instantclient_12_1"'
AddConfig 'export PATH=$PATH:$LD_LIBRARY_PATH'
AddConfig 'export SQLPATH="/opt/oracle/instantclient_12_1"'
AddConfig 'export TNS_ADMIN="/opt/oracle/network/admin"'
AddConfig 'export NLS_LANG="AMERICAN_AMERICA.UTF8"'
Log 'Finished Oracle Instant Client Installation'

######################
###RVM Installation###
######################
Log 'Starting RVM and Ruby dependencies Installation'
sudo apt-get update -y >>/home/vagrant/setup.log 2>&1
sudo apt-get install git curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libmysqlclient-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev -y >>/home/vagrant/setup.log 2>&1
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev net-tools -y >>/home/vagrant/setup.log 2>&1
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 >>/home/vagrant/setup.log 2>&1
curl -L https://get.rvm.io | bash -s stable >>/home/vagrant/setup.log 2>&1
echo 'Compiling Ruby, will take a while....'
echo -ne '######                     (33%)\r'
source /home/vagrant/.rvm/scripts/rvm
AddConfig 'source ~/.rvm/scripts/rvm'
rvm install 2.1.2 >>/home/vagrant/setup.log 2>&1
echo -ne '########             (55%)\r'
rvm use 2.1.2 --default >>/home/vagrant/setup.log 2>&1
echo -ne '#############             (66%)\r'
echo "gem: --no-ri --no-rdoc" > /home/vagrant/.gemrc
echo -ne '#######################   (100%)\r'
echo -ne '\n'
Log 'Finished RVM and Ruby dependencies Installation'

#####################
###QT Installation###
#####################
Log 'Starting QT Installation'
echo -ne '                     (0%)\r'
sudo apt-add-repository -y ppa:ubuntu-sdk-team/ppa >>/home/vagrant/setup.log 2>&1
echo -ne '######                     (33%)\r'
sudo apt-get update -y >>/home/vagrant/setup.log 2>&1
sudo apt-get install libaio1 libssl1.0-dev libqt5webkit5-dev qtdeclarative5-dev xvfb libcanberra-gtk-module libcanberra-gtk3-module -y >>/home/vagrant/setup.log 2>&1
sudo wget http://fr.archive.ubuntu.com/ubuntu/pool/main/g/gst-plugins-base0.10/libgstreamer-plugins-base0.10-0_0.10.36-1_amd64.deb >>/home/vagrant/setup.log 2>&1
sudo wget http://fr.archive.ubuntu.com/ubuntu/pool/universe/g/gstreamer0.10/libgstreamer0.10-0_0.10.36-1.5ubuntu1_amd64.deb >>/home/vagrant/setup.log 2>&1
sudo dpkg -i libgstreamer*.deb >>/home/vagrant/setup.log 2>&1
sudo rm libgstreamer*.deb >>/home/vagrant/setup.log 2>&1
QT_MAJOR_VERSION=5.5
QT_MINOR_VERSION=5.5.1
sudo wget --no-verbose http://download.qt.io/archive/qt/$QT_MAJOR_VERSION/$QT_MINOR_VERSION/qt-opensource-linux-x64-$QT_MINOR_VERSION.run >>/home/vagrant/setup.log 2>&1
sudo wget --no-verbose https://gist.githubusercontent.com/nritholtz/9a168ae35fd59d83709a/raw/75317e8fd0b81c667025212e7a427b5eb348fa75/unattended-qt-5.5-64-bit.qs >>/home/vagrant/setup.log 2>&1
echo -ne '#############             (66%)\r'
sudo chmod +x qt-opensource-linux-x64-$QT_MINOR_VERSION.run 
sudo xvfb-run ./qt-opensource-linux-x64-$QT_MINOR_VERSION.run --script unattended-qt-5.5-64-bit.qs >>/home/vagrant/setup.log 2>&1
sudo rm qt-opensource-linux-x64-$QT_MINOR_VERSION.run unattended-qt-5.5-64-bit.qs
sudo rm /usr/bin/qmake
sudo ln -s /home/vagrant/Qt/$QT_MAJOR_VERSION/*/bin/qmake /usr/bin/qmake
echo -ne '#######################   (100%)\r'
echo -ne '\n'
Log 'Finished QT Installation'


###################################
##Visual Studio Code Installation##
###################################
Log 'Starting Visual Studio Code installation'
DownloadFile https://go.microsoft.com/fwlink/?LinkID=760868 code.deb
sudo dpkg -i code.deb >> /home/vagrant/setup.log 2>&1
rm code.deb >> /home/vagrant/setup.log 2>&1
sudo apt-get install -f -y >> /home/vagrant/setup.log 2>&1
Log 'Finished Visual Studio Code installation'

###################################
##Git Installation##
###################################
Log 'Starting Git installation'
sudo apt-get install vim git git-flow -y >> /home/vagrant/setup.log 2>&1
sudo curl -L https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.bash -o /etc/bash_completion.d/git-flow >> /home/vagrant/setup.log 2>&1
Log 'Finished Git installation'

#Alias for Running Cucumber from Terminal
AddConfig 'alias cukes="bundle exec cucumber"'

Log 'Done!'
sudo shutdown -h now