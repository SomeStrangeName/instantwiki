#!/bin/sh
# maybe not the best idea :)
sudo mkdir -p /srv/wiki/images
sudo mkdir -p /srv/mysql

# to restore existing image files
#sudo tar -C /srv/wiki/ -xvf /vagrant/wiki_backup/wiki.files.tgz ./images
sudo chown root.www-data /srv/wiki/images
#sudo chown root.www-data /srv/wiki/images/* -R
sudo chmod ug+rwx /srv/wiki/images
#sudo chmod o-rwx /srv/wiki/images/* -R
#sudo chmod ug+rw /srv/wiki/images/* -R

# Start this manually
# login with "vagrant ssh"
# Start the docker
#sudo docker-compose -f /vagrant/stack.yml up &
# do the config and restart the system
# Stop the docker
#sudo docker-compose -f /vagrant/stack.yml stop
# Copy LocalSettings.php in /srv/wiki and adapt the stack.yml file
# Start the docker
# Test your wiki
# Do a vagrant reload to restart and see if the wiki is still reachable
