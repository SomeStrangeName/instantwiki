#!/bin/bash
set -x -e
sudo apt-get update
sudo apt-get install -y apt-transport-https dirmngr
# add docker repos
sudo touch /etc/apt/sources.list.d/docker.list 
sudo echo 'deb https://apt.dockerproject.org/repo debian-stretch main' >> /etc/apt/sources.list.d/docker.list
# set source list to Debian default values
# https would be nice :)
sudo echo 'deb http://ftp.de.debian.org/debian/ stretch main non-free contrib' > /etc/apt/sources.list
sudo echo 'deb-src http://ftp.de.debian.org/debian/ stretch main non-free contrib' >> /etc/apt/sources.list
sudo echo 'deb http://security.debian.org/ stretch/updates main contrib non-free' >> /etc/apt/sources.list
sudo echo 'deb-src http://security.debian.org/ stretch/updates main contrib non-free' >> /etc/apt/sources.list
sudo echo 'deb http://ftp.de.debian.org/debian/ stretch-updates main contrib non-free' >> /etc/apt/sources.list
sudo echo 'deb-src http://ftp.de.debian.org/debian/ stretch-updates main contrib non-free' >> /etc/apt/sources.list
# to load keys
# load docker key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# update to have docker pages in
sudo apt-get update
# ensure latest packages
sudo apt-get dist-upgrade -y
sudo apt-get install -y curl default-mysql-client vim git docker-engine docker-compose

# 
sudo usermod -aG docker vagrant
mycnf=~/.my.cnf
dbuser="root"
dbpw=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c64 ; echo ''`
echo $dbpw
touch $mycnf
echo '[mysqldump]' > $mycnf
echo "user=${dbuser}" >> $mycnf
echo "password=${dbpw}" >> $mycnf

# maybe not the best idea :)
sudo mkdir -p /data/wiki/images
sudo mkdir -p /data/mysql

# to restore existing image files
#sudo tar -C /data/wiki/ -xvf /vagrant/wiki_backup/wiki.files.tgz ./images
sudo chown root.www-data /data/wiki/images
sudo chown root.www-data /data/wiki/images/* -R
sudo chmod ug+rwx /data/wiki/images
sudo chmod o-rwx /data/wiki/images/* -R
sudo chmod ug+rw /data/wiki/images/* -R

# should be replaced with a docker compose file
# mariadb container
sudo docker run --name mysql -e MYSQL_ROOT_PASSWORD=${dbpw} -v /data/mysql:/var/lib/mysql -p 3306:3306 -d mariadb:latest
# mediawiki container (initial startup)
sudo docker run --name wiki --link mysql:mysql -p 8080:80 -v /data/wiki/images:/var/www/html/images -d mediawiki:latest
# if you place the LocalSettings.php file use following startup
#sudo docker run --name wiki --link mysql:mysql -p 8080:80 -v /data/wiki/images:/var/www/html/images -v /data/wiki/LocalSettings.php:/var/www/html/LocalSettings.php -d mediawiki:latest
# this will create an initial empty database for the mediawiki installation
sudo mysql -h 127.0.0.1 -u ${dbuser} -p${dbpw} < /vagrant/wiki_init/createdb.sql
# this will restore a mediawiki SQL dump
# sudo gunzip < /vagrant/wiki_backup/wiki.sql.gz | mysql -h 127.0.0.1 -u ${dbuser} -p${dbpw} mywiki

