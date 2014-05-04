# -*- mode: ruby -*-
# vi: set ft=ruby :

settings = {
  :box => 'precise32',
  :box_url => "http://files.vagrantup.com/precise32.box",
  :forwarded_ports => [{:host => 8000, :guest => 8000},
                       {:host => 8080, :guest => 8080}]
}

local_settings = "#{__FILE__}.local"
if File.exists?(local_settings)
  eval File.read(local_settings)
end

def provision vm
  vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "nodejs"
    chef.add_recipe "git"
    chef.add_recipe "python"
    chef.add_recipe "sqlite"
    chef.add_recipe "gae"
    chef.add_recipe "main"
    chef.add_recipe "main::github"
    chef.add_recipe "main::transifex"
    chef.add_recipe "main::flobot"
    chef.add_recipe "main::frontend_tools"

    chef.json.merge! JSON.parse(File.read(File.join(File.dirname(File.expand_path(__FILE__)), 'node.json')))
    # chef.log_level = :debug
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = settings[:box]
  config.vm.box_url = settings[:box_url]

  config.ssh.forward_agent = true

  config.vm.provider :vmware_fusion do |p|
    p.vmx['memsize'] = '2048'
  end

  config.vm.synced_folder "floqq", "/opt/floqq"

  for port_pair in settings[:forwarded_ports] do
    config.vm.network :forwarded_port, host: port_pair[:host], guest: port_pair[:guest]
  end

  provision config.vm
end


Vagrant::Config.run do |config|
  config.vm.box = settings[:box]

  config.vm.box_url = settings[:box_url]

  config.ssh.forward_agent = true

  # web http server
  config.vm.forward_port 8000, 8000
  # api http server
  config.vm.forward_port 8080, 8080

  config.vm.share_folder "floqq", "/opt/floqq", "./floqq"

  provision config.vm
end
