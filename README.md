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
or use `make server`, once the server is running get auth setup and add a host you’ll get something like:
```
sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.7.8 $URL
```
where `$URL` is a big long url that points at your rancher server, run `make agent` and you will be prompted for your url, or make a file url and place your URL in this file, now run the playbook and your agents should come online
```
ansible-playbook rancherosAgent.yml
```
stick a line in cron that runs it every five minutes and you’ll ensure their up and running
