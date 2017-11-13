#!/bin/bash
set -x -e
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
#sudo chown root.www-data /data/wiki/images/* -R
sudo chmod ug+rwx /data/wiki/images
#sudo chmod o-rwx /data/wiki/images/* -R
#sudo chmod ug+rw /data/wiki/images/* -R

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

