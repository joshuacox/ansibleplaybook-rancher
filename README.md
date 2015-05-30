# rancheros-playbook
Ansible playbook to keep a Rancher container running on a docker host

merely following the instructions at the link below, and ensuring the rancher/server container is started properly: 

https://github.com/rancherio/rancher

# usage

add a line to `/etc/ansible/hosts` or wherever you keep your inventory similar to:
```
[rancheros]
rancheros ansible_ssh_port=$PORT ansible_ssh_host=$IP_ADDRESS ansible_ssh_user=root
```
then you can call the playbook directly like so
```
ansible_-playbook rancheros.yml
```
