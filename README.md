EX300-sandbox-lab
=================

EX300 - RHCE - RHEL 7 - study lab configuration scripts

# Lab build
Use Vagrantfile configuration to build desktop and server machines
```
vagrant up
```
#### Result
VMs created:
- 10.0.0.5 accessible through ```vagrant ssh tom```
- 10.0.0.6 accessible through ```vagrant ssh jerry```

# DNS caching-only* name server

```dns.sh``` - OK, not only for caching. Hosts A and PTR records for:
- tom.example.com <-> 10.0.0.5
- jerry.example.com <-> 10.0.0.6

# Central mail server
``` mail.sh ``` - Postfix email server - mail.example.com

# NFS 
``` nfs-server.sh ``` - nfs kernel server - shares tom:/nfsshare(rw) with SELinux labels exported 

``` nfs-client.sh ``` - to be mounted on jerry

# Samba
``` smb-server.sh ``` - samba server configuration for multiuser mount

``` smb-client.sh ``` - samba client - mounts //tom/smbshare
