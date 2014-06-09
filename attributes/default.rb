default['consul']['install_type'] = 'binary'
default['consul']['version']      = '0.2.1'
default['consul']['user']         = 'root'
default['consul']['group']        = 'root'

default['consul']['agent']['path'] = '/usr/local/bin/consul'

default['consul']['agent']['config']['name']              = node.fqdn
default['consul']['agent']['config']['advertise']         = nil
default['consul']['agent']['config']['bootstrap']         = false
default['consul']['agent']['config']['bind_addr']         = '0.0.0.0'
default['consul']['agent']['config']['client_addr']       = '127.0.0.1'
default['consul']['agent']['config']['config_file']       = nil
default['consul']['agent']['config']['config_dir']        = '/etc/consul.d'
default['consul']['agent']['config']['data_dir']          = '/var/opt/consul'
default['consul']['agent']['config']['dc']                = 'dc1'
default['consul']['agent']['config']['join']              = []
default['consul']['agent']['config']['log_level']         = 'info'
default['consul']['agent']['config']['previous_protocol'] = false
default['consul']['agent']['config']['server']            = false
default['consul']['agent']['config']['ui_dir']            = nil
default['consul']['agent']['config']['pid_file']          = '/var/run/consul_agent.pid'

default['consul']['agent']['upstart']['gomaxprocs'] = 2
default['consul']['agent']['upstart']['respawn']['enable']   = true
default['consul']['agent']['upstart']['respawn']['limit']    = '5'
default['consul']['agent']['upstart']['respawn']['duration'] = '60'
