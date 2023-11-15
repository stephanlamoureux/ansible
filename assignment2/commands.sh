#!/bin/bash

# list all the hosts
ansible-inventory --graph -i inventory

# list only the web servers
ansible-inventory --graph -i inventory --limit web_servers

# list only the db server
ansible-inventory --graph -i inventory --limit db_servers

# Install apache in all the web servers
ansible web_servers -b -m shell -a "apt install apache2 -y ; systemctl enable --now apache2" -i inventory

# Copy a local index.html file and serve them on the installed apache web servers
ansible web_servers -b -m shell -a "git clone https://github.com/stephanlamoureux/dom-manipulation.git ;  sudo rm /var/www/html/index.html ; sudo cp -r ./dom-manipulation/. /var/www/html" -i inventory
