bash "install flobot" do
  user "root"
  cwd "/opt/floqq/deploy"
  code <<-EOH
  python setup.py install
  EOH

  package = node[:flobot][:name]
  version = node[:flobot][:version]

  not_if "[ `pip freeze | grep #{package} | cut -d'=' -f3` = #{version} ]"
end

node[:flobot][:applications].each do |app_name|
  bash "flobot - init in #{app_name}" do
    user "vagrant"
    group "vagrant"
    cwd "/opt/floqq/#{app_name}"

    code "floqq init"

    not_if do
      File.exists? "/opt/floqq/#{app_name}/.deploy"
    end
  end
end

node[:flobot][:config].each_pair do |app_name, config|
  config.each_pair do |setting, value|
    bash "flobot - config #{app_name} #{setting} as #{value} " do
      user "vagrant"
      group "vagrant"
      cwd "/opt/floqq/#{app_name}"

      code "floqq config #{setting} #{value}"
    end
  end
end
