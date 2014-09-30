#!/bin/bash

# centos7 - unbound - dns server configuration for a simple lab
# author: kamilsmuga

# unbound - install, enable on boot, start and add firewall rule
sudo -i
yum -y install unbound
systemctl enable unbound
systemctl start unbound
firewall-cmd --permanent --add-service=dns

# I want dig!
yum install bind-utils -y

# unbound configuration
# listen on all interfaces (only localhost by default)
UB_CONF=/etc/unbound/unbound.conf
sed -i '0,/# interface/{s/# interface/interface/}' $UB_CONF
# whitelist 10.0.0.0/24 subnet
sed -i 's|# access-control: 0.0.0.0/0 refuse|access-control: 10.0.0.0/24 allow|' $UB_CONF
# set forward zone to google
echo -e "forward-zone: \n \tname: . \n \tforward-addr: 8.8.8.8" >> /etc/unbound/unbound.conf

# add A records for tom, jerry and mail in example.com domain
DNS_CONF=/etc/unbound/local.d/example.conf
echo local-data: \"tom.example.com A 10.0.0.5\" > $DNS_CONF
echo local-data: \"jerry.example.com A 10.0.0.6\" >> $DNS_CONF
echo local-data: \"mail.example.com A 10.0.0.6\" >> $DNS_CONF
# add PTR records for 10.0.0.6 and 10.0.0.5
echo local-data-ptr: \"10.0.0.5 tom.example.com\" >> $DNS_CONF
echo local-data-ptr: \"10.0.0.6 jerry.example.com\" >> $DNS_CONF
echo local-data-ptr: \"10.0.0.6 mail.example.com\" >> $DNS_CONF

systemctl restart unbound
