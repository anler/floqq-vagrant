bash "web::gem-install-compass" do
  user "root"
  code "/opt/ruby/bin/gem install compass"

  not_if "[ `which compass &>/dev/null` ]"
end
