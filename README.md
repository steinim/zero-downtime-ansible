Tutorial slides will be available closer to the tutorial.
==========================================================

Install Ansible
=============

Mac:
----
Install Python setuptools: https://pypi.python.org/pypi/setuptools#installation-instructions

```sudo easy_install pip```

```sudo pip install paramiko PyYAML jinja2 passlib```

```sudo pip install ansible --quiet```

Then, if you're going to update ansible later, just do:

```sudo pip install ansible --upgrade```

Other:
------
http://www.ansibleworks.com/docs/intro_installation.html

Install VirtualBox and Extension Pack
======================================
https://www.virtualbox.org/wiki/Downloads

Install Vagrant
===============
http://docs.vagrantup.com/v2/installation/

Run: ```vagrant up```

Map the ip addresses of the VMs in your /etc/hosts
---------------------------------------------------
```ansible-playbook -i localhost --ask-sudo-pass localhost.yml```

Provision with Ansible
=======================
```ansible-playbook -i hosts --private-key=~/.vagrant.d/insecure_private_key -u vagrant site.yml```

Getting started
----------------
http://www.ansibleworks.com/docs/intro_getting_started.html

Ansible Modules
----------------
http://www.ansibleworks.com/docs/modules.html

