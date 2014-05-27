# See http://www.consul.io/docs/agent/services.html for more information

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  converge_by("Create #{@new_resource}") do
    create_consul_service
  end
end

action :delete do
  converge_by("Deleting #{@new_resource}") do
    delete_consul_service
  end
end

def load_current_resource
  @current_resource = Chef::Resource::ConsulService.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.id(@new_resource.id || @new_resource.name)
  @current_resource.tags(@new_resource.tags)
  @current_resource.port(@new_resource.port)
  @current_resource.script(@new_resource.script)
  @current_resource.interval(@new_resource.interval)
  @current_resource.ttl(@new_resource.ttl)
  @current_resource.type(@new_resource.type)
end

def consul_service(user_action)
  config_dir = node.consul.agent.config.config_dir
  service_file = "#{@current_resource.name}.json"
  service_file = ::File.expand_path(::File.join(config_dir, service_file))
  service = %w(name id tags port script interval ttl type).inject({}) do |hash, attr|
    hash[attr] = @current_resource.send attr
    hash
  end

  t = template service_file do
    source 'service.json.erb'
    owner 'root'
    group 'root'
    mode '0640'
    action user_action
    # variables check: @current_resource
    variables service: service
    # TODO: Figure out why this fails with Chef::Exceptions::ResourceNotFound
    # notifies :restart, 'service[consul_agent]'
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

def create_consul_service
  consul_service(:create)
end

def delete_consul_service
  consul_service(:delete)
end
