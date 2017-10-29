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
# load docker key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-get update
# ensure latest packages are installed
sudo apt-get dist-upgrade -y
# install curl and a mysql client to access database in docker container
sudo apt-get install -y curl default-mysql-client
# install docker
sudo apt-get install -y docker-engine
# install docker compose
# not used
#sudo apt-get install -y docker-compose

# 
sudo usermod -aG docker vagrant
# should be replaced with a docker compose file
sudo docker create -v /var/lib/mysql --name data-mysql mysql
sudo docker run --name mysql -e MYSQL_ROOT_PASSWORD=SomeStrangePassword --volumes-from data-mysql -p 3306:3306 -d mysql:latest
sudo docker run --name wiki --link mysql:mysql -p 8080:80 -v /data:/data -d synctree/mediawiki
