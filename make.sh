#!/bin/bash

# To build the proper image, supply the name of the config yaml as the first command line argument

mkdir -p /tmp/new-drive/openstack/latest
cp -v $1.yaml /tmp/new-drive/openstack/latest/user_data
mkisofs -input-charset UTF-8 -R -V config-2 -o ~/$1.iso /tmp/new-drive
rm -r /tmp/new-drive
cp ~/$1.iso /mnt/lun0/software/linux/coreos/
