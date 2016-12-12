all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""   1. make server       - run rancher server (then configure Auth)
	@echo ""   2. configure Auth then go to the add custom host page you will find the URL for your rancher Agents [http://rancherurl/static/infrastructure/hosts/add/custom]
	@echo ""   3. make agent       - run rancher agents you will be prompted for the above url (it will be cached locally, but due to gitignore it will be pretty hard for you to commit it)

server: haveged serverplay

haveged:
	ansible-playbook haveged.yml

serverplay:
	ansible-playbook rancherServer.yml

agent: url ip labels datadir agentplay

bootstrap:
	ansible-playbook bootstrapAnsible.yml

url:
	@while [ -z "$$url" ]; do \
		read -r -p "Enter the url you wish to associate with this Rancher agent [url]: " url; echo "$$url">>url; cat url; \
	done ;

ip:
	@while [ -z "$$ip" ]; do \
		read -r -p "Enter the ip of the Rancher server you wish to associate with these Rancher agents this can be left blank [ip]: " ip; echo "$$ip">>ip; cat ip; \
	done ;

datadir:
	@while [ -z "$$datadir" ]; do \
		read -r -p "Enter the datadir of the Rancher server you wish to associate with these Rancher agents [datadir]: " datadir; echo "$$datadir">>datadir; cat datadir; \
	done ;

labels:
	@while [ -z "$$labels" ]; do \
		read -r -p "Enter the cattle host labels of the Rancher server you wish to associate with these Rancher agents this can be left blank [genus=rancher&phasse=test]: " labels; echo "$$labels">>labels; cat labels; \
	done ;

agentplay:
	ansible-playbook rancherAgent.yml

console:
	ansible-playbook -vvvvv rancherOSubuntuconsole.yml

example:
	-@echo '/var/lib/rancher'>datadir

ping:
	ansible rancheros -m ping
