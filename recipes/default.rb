#
# Cookbook Name:: rs-cookbooks-ci
# Recipe:: default
#
# Copyright (C) 2013 RightScale, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt::default"

node.override['languages']['ruby']['default_version'] = node['rs-cookbooks-ci']['languages']['ruby']['default_version']
include_recipe "ruby::default"

node.override['jenkins']['server']['plugins'] = node['rs-cookbooks-ci']['jenkins']['server']['plugins']
include_recipe "jenkins::server"


#By default jenkins cookbook should install the latest version but somehow it installs a very old version which makes git unusable til updated
# jenkins_plugin 'ssh-credentials' do
#   action :install
#   version '1.4'
# end
# 
# jenkins_plugin 'ssh-slaves' do
#   action :install
#   version '1.2'
# end

node.override['vagrant']['url']      = node['rs-cookbooks-ci']['vagrant']['url']
node.override['vagrant']['checksum'] = node['rs-cookbooks-ci']['vagrant']['checksum']
node.override['vagrant']['plugins']  = node['rs-cookbooks-ci']['vagrant']['plugins'] 
include_recipe "vagrant"

include_recipe "virtualbox"
include_recipe "git"

gem_package "bundler"