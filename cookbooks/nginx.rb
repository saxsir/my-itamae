%w{
  nginx
  nginx-common
}.each do |pkg|
  package pkg
end

service "nginx" do
  action [:enable, :reload]
end

template "/etc/nginx/nginx.conf" do
  action :create
  source "nginx/templates/nginx.conf.erb"
  mode "0644"
  notifies :reload, "service[nginx]"
end
