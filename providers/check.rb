# See http://www.consul.io/docs/agent/checks.html for more information

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  converge_by("Create #{@new_resource}") do
    create_consul_check
  end
end

action :delete do
  converge_by("Deleting #{@new_resource}") do
    delete_consul_check
  end
end

def load_current_resource
  @current_resource = Chef::Resource::ConsulCheck.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.id(@new_resource.id || @new_resource.name)
  @current_resource.script(@new_resource.script)
  @current_resource.interval(@new_resource.interval)
  @current_resource.ttl(@new_resource.ttl)
  @current_resource.type(@new_resource.type)
end

def consul_check(user_action)
  config_dir = node.consul.agent.config.config_dir
  check_file = "#{@current_resource.name}.json"
  check_file = File.expand_path(File.join(config_dir, check_file))
  check = %w(name id script interval ttl type).inject({}) do |hash, attr|
    hash[attr] = @current_resource.send attr
    hash
  end

  t = template(check_file) do
    source 'check.json.erb'
    owner node.consul.user
    group node.consul.group
    mode '0640'
    action user_action
    # variables check: @current_resource
    variables check: check
    # TODO: Figure out why this fails with Chef::Exceptions::ResourceNotFound
    # notifies :reload, "service[consul_agent]"
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

def create_consul_check
  consul_check(:create)
end

def delete_consul_check
  consul_check(:delete)
end
