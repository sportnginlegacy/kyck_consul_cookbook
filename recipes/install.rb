consul = node.consul

include_recipe "consul::#{consul.install_type}_install"

data_dir   = consul.agent.config.data_dir
config_dir = consul.agent.config.config_dir
user       = consul.user
group      = consul.group

directory data_dir do
  owner user
  group group
  mode 0744
end

directory config_dir do
  owner user
  group group
  mode 0744
end

template "#{config_dir}/config.json" do
  source "config.json.erb"
  owner user
  group group
  mode 0644
end
