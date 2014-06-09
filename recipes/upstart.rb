include_recipe 'consul::install'

template '/etc/init/consul.conf' do
  source 'consul.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
end

service 'consul_agent' do
  service_name 'consul'
  provider Chef::Provider::Service::Upstart
  supports start:   true,
           stop:    true,
           restart: true,
           reload:  true,
           status:  true
  action [:enable, :start]
end
