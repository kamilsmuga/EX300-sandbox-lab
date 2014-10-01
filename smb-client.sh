#!/bin/bash

# centos7 - samba client configuration 
# author: kamilsmuga

yum install -y cifs-utils

echo "username=tom" >> /root/smb.creds
echo "password=tom" >> /root/smb.creds

mkdir -p /mnt/smbshare

echo "10.0.0.5:/smbshare /mnt/smbshare cifs multiuser,credentials=/root/smb.creds,sec=ntlmssp 0 0" >> /etc/fstab
mount -a
