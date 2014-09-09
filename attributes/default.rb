default['consul']['install_type'] = 'binary'
default['consul']['version']      = '0.3.0'
default['consul']['user']         = 'root'
default['consul']['group']        = 'root'

default['consul']['agent']['path'] = '/usr/local/bin/consul'

default['consul']['agent']['config']['name']              = node.fqdn
default['consul']['agent']['config']['advertise']         = nil
default['consul']['agent']['config']['bootstrap']         = false
default['consul']['agent']['config']['bind_addr']         = '0.0.0.0'
default['consul']['agent']['config']['client_addr']       = '127.0.0.1'
default['consul']['agent']['config']['dc']                = 'dc1'
default['consul']['agent']['config']['config_file']       = nil
default['consul']['agent']['config']['config_dir']        = '/etc/consul.d'
default['consul']['agent']['config']['data_dir']          = '/var/opt/consul'
default['consul']['agent']['config']['join']              = []
default['consul']['agent']['config']['log_level']         = 'info'
default['consul']['agent']['config']['previous_protocol'] = false
default['consul']['agent']['config']['server']            = false
default['consul']['agent']['config']['ui_dir']            = nil
default['consul']['agent']['config']['pid_file']          = '/var/run/consul_agent.pid'
default['consul']['agent']['config']['vpc_is_dc']         = true

# Place this in a wrapper cookbook
if node['consul']['agent']['config']['vpc_is_dc']
  mac    = node['ec2']['mac']
  vpc_id = node['ec2']['network_interfaces_macs'][mac]['vpc_id']

  default['consul']['agent']['config']['dc'] = vpc_id
else
  default['consul']['agent']['config']['dc'] = 'dc1'
end

# Place this in a wrapper cookbook
if true
# if node['consul']['agent']['config']['separate_dc_for_each_env']
  dc = default['consul']['agent']['config']['dc']
  default['consul']['agent']['config']['dc'] = "#{dc}-#{node.environment}"
end

default['consul']['agent']['upstart']['gomaxprocs'] = 2
default['consul']['agent']['upstart']['respawn']['enable']   = true
default['consul']['agent']['upstart']['respawn']['limit']    = '5'
default['consul']['agent']['upstart']['respawn']['duration'] = '60'

default['consul']['web']['url'] = 'consul.example.com'
