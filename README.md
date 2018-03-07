## Start

First, install Ansible and Python

	$ pacman -Syy python2-passlib ansible

	Or if it is on OSX

	$ ansible-playbook -i localhost playbook.yml  --tags mac

And then execute the playbook

	$ ansible-playbook -i localhost playbook.yml
