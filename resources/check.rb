# See http://www.consul.io/docs/agent/checks.html for more information

actions :create, :delete
default_action :create

interval_regex = /\d+[smh]/

attribute :name,     kind_of: String, name_attribute: true, required: true

attribute :id,       kind_of: String, default: nil
attribute :script,   kind_of: String, default: nil
attribute :interval, kind_of: String, default: nil,     regex: interval_regex
attribute :ttl,      kind_of: String, default: nil,     regex: interval_regex
attribute :type,     kind_of: Symbol, default: :script, equal_to: [:script, :ttl]
