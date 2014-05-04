node[:transifex][:applications].each do |name|
  bash "initializing transifex in /opt/floqq/#{name}" do
    cwd "/opt/floqq/#{name}"
    code <<-EOH
    tx init --host=#{node['transifex']['host']} --user=#{node['transifex']['user']} --pass=#{node['transifex']['password']}
    EOH

    not_if do   # Only do this if we have allready checked out
      File.exists? "/opt/floqq/#{name}/.tx"
    end
  end
end

template "/home/vagrant/.transifexrc" do
  source "transifexrc"
  owner "vagrant"
  group "vagrant"

  action :create_if_missing
end
