# See http://www.consul.io/docs/agent/services.html for more information

actions :create, :delete
default_action :create

interval_regex = /\d+[smh]/

attribute :name,     kind_of: String, name_attribute: true, required: true
attribute :id,       kind_of: String
attribute :tags,     kind_of: Array
attribute :port,     kind_of: Fixnum
attribute :script,   kind_of: String
attribute :interval, kind_of: String, default: nil, regex: interval_regex
attribute :ttl,      kind_of: String, default: nil, regex: interval_regex
attribute :type,     kind_of: Symbol, default: nil, equal_to: [:script, :ttl]
