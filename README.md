# ansibleplaybook-rancher
Ansible playbook to keep a [Rancher](http://rancher.com/) container running on a docker host

 I am merely following the instructions at this [link] (https://github.com/rancherio/rancher)
, and ensuring the rancher/server container is started properly you can then use ansible to maintain 
containers, ansible docs [here](http://docs.ansible.com/ansible/docker_module.html)

## Quick Start from installing RancherOS

Append the example hosts to your ansible hosts file

```
cat hosts>>/etc/ansible/hosts
```

Now replace $IPADDRESS and $PORT in that file as necessary

now enable the ubuntu-console, if you did not do so in cloud-config

```
make console
```

then bootstrap python for ansible to function:

```
make bootstrap
```

Note: this may hang, `ctrl-C` if it does, and test:

```
make ping
```

Then you can 

```
make server
```

and

```
make agent
```

## detailed usage

add these lines to `/etc/ansible/hosts` or wherever you keep your inventory similar to:
For the host that runs the rancher server
```
[rancherserver]
rancherserver ansible_ssh_port=$PORT ansible_ssh_host=$IP_ADDRESS ansible_ssh_user=root
```

For the hosts that run the rancher agents
```
[rancheragent]
rancheragent ansible_ssh_port=$PORT ansible_ssh_host=$IP_ADDRESS ansible_ssh_user=root
```

For the hosts that run the rancherOS, 
```
[rancheros]
rancheros ansible_ssh_port=$PORT ansible_ssh_host=$IP_ADDRESS ansible_ssh_user=root
```
you need to get each of the RancherOS VMs them running the ubuntu-console, log into each and `sudo ros service enable ubuntu-console;`
or you can call the console playbook directly like so
```
ansible-playbook rancherOSubuntuconsole.yml
```
or `make console` to set the ubuntu console in all your rancherOS images (needed for ansible to run)

and then you’ll need to install python, `make bootstrap`, then get the server up
```
ansible-playbook rancherServer.yml
```
or use `make server`, once the server is running get auth setup and add a host you’ll get something like:
```
sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.7.8 $URL
```
where `$URL` is a big long url that points at your rancher server, run `make agent` and you will be prompted for your url, or make a file url and place your URL in this file, now run the playbook and your agents should come online
```
ansible-playbook rancherAgent.yml
```
stick a line in cron that runs it every five minutes and you’ll ensure their up and running
