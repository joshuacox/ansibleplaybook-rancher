# ansibleplaybook-rancher
Ansible playbook to keep a [Rancher](http://rancher.com/) container running on a docker host

 I am merely following the instructions at this [link] (https://github.com/rancherio/rancher)
, and ensuring the rancher/server container is started properly


## usage

add these lines to `/etc/ansible/hosts` or wherever you keep your inventory similar to:
```
[rancherserver]
rancherserver ansible_ssh_port=$PORT ansible_ssh_host=$IP_ADDRESS ansible_ssh_user=root

[rancheragent]
rancheragent ansible_ssh_port=$PORT ansible_ssh_host=$IP_ADDRESS ansible_ssh_user=root
```
then you can call the playbooks directly like so
```
ansible-playbook rancherosServer.yml
```
once the server is running get auth setup and add a host you’ll get something like:
```
sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.7.8 $URL
```
where `$URL` is a big long url that points at your rancher server, modify rancherAgent and replace URL with your URL in the command section of the playbook, now run the playbook and your agents should come online
```
ansible-playbook rancherosAgent.yml
```
stick a line in cron that runs it every five minutes and you’ll ensure their up and running
