#
# Cookbook Name:: consul
# Recipe:: default
#
# Copyright (C) 2014 Kyck
#
# All rights reserved - Do Not Redistribute
#

chef_gem 'aws-sdk' do
  version node['aws-sdk']['version']
  action install
end

require 'aws-sdk'
