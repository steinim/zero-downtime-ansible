Intro
======
This is the starting point for a tutorial which will be held at the Velocity Conference in Barcelona November 19th.

[Abstract](http://velocityconf.com/velocityeu2014/public/schedule/detail/37017)

Tutorial slides will be available closer to the conference.

Install Ansible
=============

Mac:
----
Install Python setuptools: https://pypi.python.org/pypi/setuptools#installation-instructions

```sudo easy_install pip```

```sudo pip install paramiko PyYAML jinja2 passlib```

```sudo pip install ansible```

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

Install vagrant-cachier to speed up apt with a shared cache between boxes:

```vagrant plugin install vagrant-cachier```

Bring the boxes up:

```vagrant up```

Install Java and Maven (Optional)
======================
http://www.oracle.com/technetwork/articles/javase/index-jsp-138363.html

http://maven.apache.org/download.cgi

Map the ip addresses of the VMs in your /etc/hosts
---------------------------------------------------
```ansible-playbook -i localhost --ask-sudo-pass localhost.yml```

Provision with Ansible
=======================
```ansible-playbook site.yml```

Getting started
----------------
http://www.ansibleworks.com/docs/intro_getting_started.html

Ansible Modules
----------------
http://www.ansibleworks.com/docs/modules.html

