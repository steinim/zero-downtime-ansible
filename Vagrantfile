# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Local box
  #config.vm.box_url = "box/precise64.box"
  
  # Vagrant Cloud box
  config.vm.box = "hashicorp/precise64"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end

  config.vm.define :db do |db|
    db.vm.network :private_network, ip: "192.168.101.10"
    db.vm.network "forwarded_port", guest: 3306, host: 3306, auto_correct: true
    db.vm.hostname = "db.local"
    db.hostmanager.aliases = %w(db)

    #db.vm.provision "ansible" do |ansible|
    #  ansible.playbook = "site.yml"
    #  ansible.inventory_path = "hosts"
    #  ansible.host_key_checking = "false"
    #  ansible.limit = "db.local"
    #end

  end

  config.vm.define :app1 do |app1|
    app1.vm.network :private_network, ip: "192.168.101.11"
    app1.vm.network "forwarded_port", guest: 1234, host: 1234, auto_correct: true
    app1.vm.hostname = "app1.local"
    app1.hostmanager.aliases = %w(app1)

    #app1.vm.provision "ansible" do |ansible|
    #  ansible.playbook = "site.yml"
    #  ansible.inventory_path = "hosts"
    #  ansible.host_key_checking = "false"
    #  ansible.limit = "app1.local"
    #end

  end

  config.vm.define :app2 do |app2|
    app2.vm.network :private_network, ip: "192.168.101.12"
    app2.vm.network "forwarded_port", guest: 1234, host: 1234, auto_correct: true
    app2.vm.hostname = "app2.local"
    app2.hostmanager.aliases = %w(app2)

    #app2.vm.provision "ansible" do |ansible|
    #  ansible.playbook = "site.yml"
    #  ansible.inventory_path = "hosts"
    #  ansible.host_key_checking = "false"
    #  ansible.limit = "app2.local"
    #end

  end

  config.vm.define :proxy do |proxy|
    proxy.vm.network :private_network, ip: "192.168.101.13"
    proxy.vm.network "forwarded_port", guest: 80, host: 8000, auto_correct: true
    proxy.vm.network "forwarded_port", guest: 443, host: 4430, auto_correct: true
    proxy.vm.hostname = "proxy.local"
    proxy.hostmanager.aliases = %w(proxy)

    #proxy.vm.provision "ansible" do |ansible|
    #  ansible.playbook = "site.yml"
    #  ansible.inventory_path = "hosts"
    #  ansible.host_key_checking = "false"
    #  ansible.limit = "proxy.local"
    #end
  end

end
