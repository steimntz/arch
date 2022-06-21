## Start

First, install Ansible and Python

```bash
$ pacman -Syy python2-passlib ansible
```

And then execute the playbook

```bash
$ ansible-playbook -i localhost playbook.yml  --tags="everything"
```
