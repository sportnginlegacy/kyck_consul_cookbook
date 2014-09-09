package 'unzip'

consul = node['consul']

version = consul['version']
zip     = "#{version}_web_ui.zip"
url     = "https://dl.bintray.com/mitchellh/consul/#{zip}"
temp    = '/tmp/consul_web_ui.zip'
extract = '/tmp/dist'

directory consul['agent']['config']['ui_dir'] do
  owner user
  group user
  mode 0744
  recursive true
end

remote_file 'consul_web_ui' do
  source url
  use_last_modified true
  path temp
  notifies :run, 'execute[unzip_web_ui]', :immediately
end

execute 'unzip_web_ui' do
  command "unzip #{temp}"
  cwd '/tmp'
  action :nothing
  notifies :run, 'execute[mv_web_ui]', :immediately
end

execute 'mv_web_ui' do
  command "mv #{extract} #{consul['agent']['config']['ui_dir']}"
  action :nothing
end

template '/etc/nginx/sites-available/consul_web' do
  source 'nginx_site.erb'
  owner 'root'
  group 'root'
  mode 0744
  notifies :reload, 'service[nginx]'
end

nginx_site 'consul_web' do
  enable true
end

cookbook_file '/etc/nginx/.passwd' do
  path '/etc/nginx/.passwd'
  source 'passwd'
  owner 'root'
  group 'root'
  mode  '0640'
end
