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

## Prerequisites
To build the wiki you need following software packages (available in Debian 9 stretch):

| Package         | Version       |
| --------------- | ------------- |
| virt-manager    | 1.4.0         |
| libvirt0        | 3.0.0-4       |
| vagrant         | 1.9.1         |
| vagrant-libvirt | 0.0.37-1      |
| qemu-kvm        | 2.8           |

## Usage
1. `git clone https://github.com/SomeStrangeName/instantwiki.git`
2. adapt files according to your needs (for example the database password)
3. `vagrant up` (this may take some time :))
4. open url in your browser: http://192.168.33.88:8080/

You will see the initial MediaWiki setup screen.
