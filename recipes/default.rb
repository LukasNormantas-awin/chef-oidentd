#
# Cookbook Name:: oidentd
# Recipe:: default
#
# Copyright 2011-2013, Binary Marbles Trond Arve Nordheim
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if platform_family?('rhel')
  include_recipe 'yum-epel'
end

# Install oidentd.
package "oidentd" do
  action :install
end

# Set up the oidentd service.
service "oidentd" do
  action :enable
end

# Generate oidentd config file.
template "/etc/oidentd.conf" do
  source "oidentd.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[oidentd]"
end

# Start oidentd.
service "oidentd" do
  action :start
end
