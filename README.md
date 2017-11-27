# instantwiki
Docker based Mediawiki installation in a QEMU/KVM machine using Vagrant for setup

## Motivation
This repository contains an experiment to evaluate different techniques. Maybe it is useful for someone.

## Contribute?
If you see issues, bad code :) or have some feedback, just open an issue and let me know.

## Content
You can clone this repository and start a new virtual machine with the command: vagrant up
It will use libvirt as provider and creates a new QEMU/KVM with a Debian 9 (stretch) in it.

After that a docker environment will be installed to setup a running Mediawiki and a database instance.

## Prerequisites for the host system
### Debian stretch 9
Ensure your CPU supports virtualization techniques and your kernel supports KVM already.

You can check with following commands:
 - `grep -E '^flags.*\b(vmx|svm)\b' /proc/cpuinfo `
If result is empty, your CPU seems not supporting vmx.

With following command you can check if kvm modules are loaded:
 - `lsmod | grep kvm`


To build the wiki you need following software packages (available in Debian 9 stretch):

| Package         | Version       |
| --------------- | ------------- |
| virt-manager    | 1.4.0         |
| libvirt0        | 3.0.0-4       |
| vagrant         | 1.9.1         |
| vagrant-libvirt | 0.0.37-1      |
| vagrant-sshfs   | 1.3.0-2       |
| qemu-kvm        | 2.8           |

Ensure your user is in sudo group (/etc/group).

### Networking
You may notice that your virtual machine is not reachable over public_network IP from your own host. Here following links may help:
 - https://wiki.math.cmu.edu/iki/wiki/tips/20140303-kvm-macvtap.html
 - https://wiki.mef.net/display/CESG/Hairpin+Switching

### Windows 7
On Windows the script works with VirtualBox and Vagrant (latest version). You will find this here:
 - https://www.virtualbox.org/
 - https://www.vagrantup.com/downloads.html

## Usage
1. `git clone https://github.com/SomeStrangeName/instantwiki.git`
2. adapt files according to your needs (for example the database password)
3. `vagrant up` (this may take some time :))
4. open url in your browser: http://192.168.33.88:8080/

You will see the initial MediaWiki setup screen.

## Used software inside the vm
 - Docker version: Docker version 17.09.0-ce, build afdb6d4 (or later)
 - Docker-compose version: docker-compose version 1.17.1, build 6d101fb
 - a mysql client
 - vim

Two docker images:
1. MariaDB: https://hub.docker.com/_/mariadb/
2. MediaWiki: https://hub.docker.com/_/mediawiki/

# Helpful links
* [Mediawiki Backup script](https://www.mediawiki.org/wiki/Manual:Backing_up_a_wiki/Duesentrieb%27s_backup_script)
