default['aws-sdk'] = {
  'version' => '1.41.0'
}

default['consul'] = {
  'install_type' => 'binary',
  'version'      => '0.2.1',
  'user'         => 'root',
  'group'        => 'root',
  'agent'        => {
    'path'     => '/usr/local/bin/consul',
    'config' => {
      'name'              => node.fqdn,
      'advertise'         => nil,
      'bootstrap'         => false,
      'bind_addr'         => '0.0.0.0',
      'client_addr'       => '127.0.0.1',
      'config_file'       => nil,
      'config_dir'        => '/etc/consul.d',
      'data_dir'          => '/var/opt/consul',
      'dc'                => 'dc1',
      'join'              => [],
      'log_level'         => 'info',
      'previous_protocol' => false,
      'server'            => false,
      'ui_dir'            => nil,
      'pid_file'          => '/var/run/consul_agent.pid'
    },
    'upstart' => {
      'gomaxprocs' => 2,
      'respawn'    => {
        'enable'   => true,
        'limit'    => '5',
        'duration' => '60',
      }
    }
  }
}
