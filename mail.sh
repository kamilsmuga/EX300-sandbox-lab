#!/bin/bash

# centos7 - postfix - central mail server configuration
# author: kamilsmuga

# postfix - install, enable on boot, start and add firewall rule
sudo -i
yum install -y postfix
firewall-cmd --permanent --add-service=smtp
firewall-cmd --reload
systemctl enable postfix
systemctl start postfix

# postfix configuration
POST_CFG=/etc/postfix/main.cf

echo myhostname = mail.example.com >> $POST_CFG
echo mydomain = example.com >> $POST_CFG
echo myorigin = \$mydomain >> $POST_CFG
sed -i 's/inet_interfaces = localhost/inet_interfaces = all/' $POST_CFG
sed -i 's#mydestination = $myhostname#mydestination = $mydomain, $myhostname#' $POST_CFG
echo mynetworks = 10.0.0.0/24, 127.0.0.0/8 >> $POST_CFG

systemctl restart postfix
