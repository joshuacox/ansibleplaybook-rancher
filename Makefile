all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make server       - run rancher server (then configure Auth)
	@echo ""   2. configure Auth then go to the add custom host page you will find the URL for your rancher Agents [http://rancherurl/static/infrastructure/hosts/add/custom]
	@echo ""   3. make agent       - run rancher agents you will be prompted for the above url (it will be cached locally, but due to gitignore it will be pretty hard for you to commit it)

server:
	ansible-playbook rancherosServer.yml

agent: url agentplay

url:
	@while [ -z "$$url" ]; do \
		read -r -p "Enter the url you wish to associate with this Rancher agent [url]: " url; echo "$$url">>url; cat url; \
	done ;

agentplay:
	ansible-playbook rancherosAgent.yml
