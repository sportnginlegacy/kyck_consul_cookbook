package 'unzip'

version = node['consul']['version']
os      = node['os']
arch    = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'
zip     = "#{version}_#{os}_#{arch}.zip"
url     = "https://dl.bintray.com/mitchellh/consul/#{zip}"
temp    = '/tmp/consul.zip'
extract = '/tmp/consul'

remote_file 'consul' do
  source url
  use_last_modified true
  path temp
  notifies :run, "execute[unzip_consul]", :immediately
end

execute 'unzip_consul' do
  command "unzip #{temp}"
  cwd '/tmp'
  action :nothing
  notifies :run, "execute[mv_consul]", :immediately
end

execute 'mv_consul' do
  command "mv #{extract} #{node['consul']['agent']['path']}"
  action :nothing
end
