# Ansible Basics

## Ansible AD hoc

### Ping servers
ping servers using ping module
```
ansible all -i hosts -m ping
```
### Adress servers using linodes

```
ansible linodes -i hosts -m ping
```
You can also only address a server using the IP-address

### Disable host key check:
Disable SSH-Key check -> Less secure. 
Disable inside the ansible config inside `/etc/ansible/ansible.cfg/`
or in `.ansible.cfg`
```sh
[defaults]
host_key_checking = false
```
