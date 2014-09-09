consul      = node['consul']
consul_cmd  = consul['agent']['path']
join_cmd    = "#{consul_cmd} join"
data_center = consul['agent']['config']['dc']

cluster_nodes = search(:node, "consul_agent_config_dc:#{data_center}")
node_addrs    = cluster_nodes.reduce([]) { |addrs, consul_node|
  if consul_node.name != node.name
    if consul_node['ec2']
      addrs << consul_node['ec2']['local_ipv4']
    else
      addrs << consul_node['ipaddress']
    end
  end
  addrs
}

execute "#{join_cmd} #{node_addrs.join(' ')}"
