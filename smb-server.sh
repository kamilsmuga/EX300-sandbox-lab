#!/bin/bash

# centos7 - samba server - export for multiple users
# share /smbshare writable only to cartoon group
# author: kamilsmuga

yum -y install samba samba-client cifs-utils
systemctl enable smb
systemctl start smb
firewall-cmd --permanent --add-service=samba
firewall-cmd --reload

mkdir -p /smbshare
groupadd cartoon
# tom will be able to read and write
useradd -G cartoon tom -s /sbin/nologin -p tom
# zorro no - he is not a cartoon. obviously
useradd zorro -s /sbin/nologin -p zorro
chown :cartoon /smbshare
chmod 2755 /smbshare

SMB_CFG=/etc/samba/smb.conf
echo "[public]" >> $SMB_CFG
echo "path = /smbshare" >> $SMB_CFG
echo "public = no" >> $SMB_CFG
echo "writable = no" >> $SMB_CFG
echo "printable = yes" >> $SMB_CFG
echo "write list = +cartoon" >> $SMB_CFG

# set selinux context
semanage fcontext -a -t samba_share_t "/smbshare/(/.*)?"
restorecon -vvFR /smbshare/

# add users to smb db
echo "zorro" > smbpasswd zorro -s
echo "tom" > smbpasswd tom -s

systemctl restart smb
