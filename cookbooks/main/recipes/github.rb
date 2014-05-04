include_recipe "main::ssh"


node[:github].each_pair do |name, url|
  execute "clone-#{url}" do
    command "git clone #{url} /opt/floqq/#{name}"
    not_if do   # Only do this if we have allready checked out
      File.exists? "/opt/floqq/#{name}/.git"
    end
  end
end
