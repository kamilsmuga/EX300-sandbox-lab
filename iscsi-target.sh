#!/bin/bash

# centos7 - shares block storage as iscsi target
# author: kamilsmuga

# let's cut a piece from root logical volume
# my /dev/centos/root is 6G 
# this is very RISKY business 
# with a bit of luck it screwes up FS and VM has to be rebuild
lvresize -L 5.9G /dev/centos/root
lvcreate -n /dev/centos/mylvm -L 100M centos
mkfs.xfs /dev/centos/mylvm

# install targetd and cli util
yum -y install targetd targetcli
systemctl enable targetd 
systemctl start targetd 
firewall-cmd --permanent --add-port=3260/tcp
firewall-cmd --reload

# create block backstore from mylvm partition
targetcli backstores/block create disk1 /dev/centos/mylvm
# create icssi target
targetcli iscsi/ create wwn=iqn.2014-10.example.com:jerry
# create lun from backstore
targetcli /iscsi/iqn.2014-10.example.com:jerry/tpg1/luns create /backstores/block/disk1
# add tom to ACLS
targetcli iscsi/iqn.2014-10.example.com:jerry/tpg1/acls create iqn.2014-10.example.com:tom
# create portal na 3260
targetcli iscsi/iqn.2014-10.example.com:jerry/tpg1/portals create 0.0.0.0
# save config
targetcli saveconfig
