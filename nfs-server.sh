#!/bin/bash

# centos7 - nfs server - export nfs with SELinux labels
# set it up on tom
# TBD to make it more fun: add krb5p authentication
# author: kamilsmuga

yum -y install nfs-utils
firewall-cmd --permanent --add-service=nfs
firewall-cmd --reload
systemctl enable nfs-server

mkdir -p /nfsshare
cal > /nfsshare/calendar.out
echo "/nfsshare 10.0.0.6(rw)" >> /etc/exports

# export selinux labels
sed -i 's|RPCNFSDARGS=""|RPCNFSDARGS="-V 4.2"|' /etc/sysconfig/nfs

systemctl start nfs-server
