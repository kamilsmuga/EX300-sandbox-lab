#!/bin/bash

# centos7 - postfix - central mail server configuration
# author: kamilsmuga

# postfix - install, enable on boot, start and add firewall rule
yum install -y postfix
firewall-cmd --permanent --add-service=smtp
firewall-cmd --reload
systemctl enable postfix
systemctl start postfix

# postfix configuration
POST_CFG=/etc/postfix/main.cf

echo myhostname = jerry.example.com >> $POST_CFG
# route to mail.example.com - configurable in dns
echo relayhost = mail.example.com >> $POST_CFG
echo mydomain = example.com >> $POST_CFG
echo myorigin = jerry.example.com >> $POST_CFG
echo local_transport = error: local delivery disabled >>  $POST_CFG
# listen for all mails sent on looback
sed -i 's/inet_interfaces = localhost/inet_interfaces = loopback-only/' $POST_CFG
sed -i 's#mydestination = $myhostname#mydestination = $mydomain, $myhostname#' $POST_CFG
echo mynetworks = 127.0.0.0/8 [::1]/128 >> $POST_CFG

systemctl restart postfix
