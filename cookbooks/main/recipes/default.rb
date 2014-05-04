cookbook_file "/home/vagrant/.bash_profile" do
  source "bash_profile"
  mode 0640
  owner "vagrant"
  group "vagrant"
end

node[:packages].each do |pkg|
  package pkg do
    action :install
    retries 3
  end
end

node[:pip_python_packages].each_pair do |pkg, version|
  execute "pip-install-#{pkg}" do
    if version == ''
      command "pip install #{pkg}"
    else
      command "pip install #{pkg}==#{version}"
    end

    not_if "[ `pip freeze | grep #{pkg} | cut -d'=' -f3` = '#{version}' ]"
  end
end

node[:npm_packages].each_pair do |pkg, version|
  execute "npm-install-#{pkg}" do
    if version == ''
      command "npm install -g #{pkg}"
    else
      command "npm install -g #{pkg}@#{version}"
    end

    not_if "[ -e /usr/local/lib/node_modules/#{pkg} ]"
  end
end
