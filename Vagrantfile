# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.customize ["modifyvm", :id, "--name", "VagrantRails", "--memory", "768"]
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.host_name = "VagrantRails"
  config.vm.network :hostonly, "33.33.13.37"
  config.vm.forward_port 22, 2222, auto: true
  config.vm.forward_port 80, 4567, auto: true
  config.vm.share_folder "puppet", "/usr/share/puppet", "puppet"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.options = "-v"
    puppet.manifest_file = "site.pp"
  end
end
