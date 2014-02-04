#
# Cookbook Name:: rs-cookbooks_ci
# Recipe:: vagrant
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

node.override['vagrant']['url'] = node['rs-cookbooks_ci']['vagrant']['url']
node.override['vagrant']['checksum'] = node['rs-cookbooks_ci']['vagrant']['checksum']

include_recipe 'vagrant'

# TODO: Remove this workaround after upgrading to Vagrant 1.3.X
# When running `vagrant plugin install vagrant-berkshelf` there is a problem
# with pulling in nokogiri. It fails during the build.

execute 'install nokogiri' do
  command 'gem install nokogiri --no-rdoc --no-ri --install-dir /var/lib/jenkins/.vagrant.d/gems'
  user 'jenkins'
  environment(
    'GEM_PATH' => '/var/lib/jenkins/.vagrant.d/gems'
  )
  not_if 'GEM_PATH=/var/lib/jenkins/.vagrant.d/gems gem list | grep nokogiri'
end
