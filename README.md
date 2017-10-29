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

