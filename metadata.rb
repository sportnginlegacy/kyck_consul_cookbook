name             'consul'
maintainer       'Brandon Dennis'
maintainer_email 'dennis@kyck.com'
license          'All rights reserved'
description      'Installs/Configures consul'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'consul::install', 'Includes correct install recipe based on attributes'
recipe 'consul::binary_install', 'Installs consul binary'
recipe 'consul::upstart', 'Creates upstart config for consul'

supports 'ubuntu'

attribute 'consul/install_type',
  display_name: 'Installation Method',
  description: 'Install via binary or source',
  default: 'binary'

attribute 'consul/version',
  display_name: 'Consul Version',
  description: 'Version of Consul to install',
  default: '0.2.1'

attribute 'consul/user',
  display_name: 'Consul User',
  description: 'Owner of files',
  default: 'root'

attribute 'consul/group',
  display_name: 'Consul Group',
  description: 'Group ownership of files',
  default: 'root'

attribute 'consul/agent/path',
  display_name: 'Consul Executable',
  description: 'Location of the Consul executable',
  default: '/usr/local/bin/consul'

attribute 'consul/agent/config',
  display_name: 'Consul config',
  description: 'Configuration for the consul agent',
  default: 'See http://www.consul.io/docs/agent/options.html'

attribute 'consul/upstart',
  display_name: 'Upstart config',
  description: 'Settings for the upstart job'
