%w{
  mackerel-agent
  mackerel-agent-plugins
}.each do |pkg|
  package pkg
end

template "/etc/mackerel-agent/mackerel-agent.conf" do
  action :create
  source "mackerel/templates/mackerel-agent.conf.erb"
  mode "0600"
  variables(
    apikey: `cat /etc/mackerel-apikey.conf`.sub(/\n/, ''),
    mysql_username: `cat /etc/mysql/debian.cnf | grep user | awk '{ print $3 }' | uniq`.sub(/\n/, ''),
    mysql_password: `cat /etc/mysql/debian.cnf | grep password | awk '{ print $3 }' | uniq`.sub(/\n/, '')
  )
end

service "mackerel-agent" do
  action [:enable]
end
