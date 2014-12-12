DownloadFile () {
  sudo wget $1 -O $2
}
sudo mkdir /opt/oracle
cd /opt/oracle
DownloadFile https://www.dropbox.com/s/2y1ha97e5ihp880/instantclient-sqlplus-linux-12.1.0.2.0.zip?dl=0 instantclient-sqlplus-linux-12.1.0.2.0.zip
DownloadFile https://www.dropbox.com/s/dxp5hgi4kpqikip/instantclient-sdk-linux-12.1.0.2.0.zip?dl=0 instantclient-sdk-linux-12.1.0.2.0.zip
DownloadFile https://www.dropbox.com/s/rhny5u3y95c1fjc/instantclient-basic-linux-12.1.0.2.0.zip?dl=0 instantclient-basic-linux-12.1.0.2.0.zip
sudo unzip \*.zip
rm -rf instant*.zip
cd instantclient_12_1
sudo ln -s libclntsh.so.12.1 libclntsh.so 
sudo mkdir network
sudo mkdir network/admin
touch network/admin/tnsnames.ora