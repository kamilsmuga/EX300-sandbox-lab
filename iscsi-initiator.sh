#!/bin/bash

# centos7 - initiate iscsi connection
# author: kamilsmuga

yum -y install iscsi-initiator-utils
systemctl enable iscsid iscsiuio

# identify yourself as configured on target
echo InitiatorName=iqn.2014-10.example.com:tom > /etc/iscsi/initiatorname.iscsi
systemctl start iscsid iscsiuio
# discover targets on jerry
iscsiadm --mode discoverydb --type sendtargets --portal 10.0.0.6 --discover
# login (and mount) jerry's device
iscsiadm --mode node --targetname iqn.2014-10.example.com:jerry --portal 10.0.0.6:3260 --login
