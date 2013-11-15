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

calculate_vagrant_url = ruby_block "get_sha_from_github" do
  block do
    require 'json'
    file_name = "vagrant_#{node['rs-cookbooks_ci']['vagrant']['version']}_x86_64.deb"
    get_sha = Mixlib::ShellOut.new(
      "wget https://api.github.com/repos/mitchellh/vagrant/git/refs/tags/v#{node['rs-cookbooks_ci']['vagrant']['version']}" +
      " -O /tmp/temp.json"
    )
    get_sha.run_command
    hash = JSON.load(IO.read("/tmp/temp.json"))
    node.set['vagrant']['checksum'] = hash['object']['sha']
    node.set['vagrant']['url'] = "http://files.vagrantup.com/packages/#{hash['object']['sha']}/#{file_name}"
  end
end

calculate_vagrant_url.run_action(:run)

include_recipe "vagrant"

# TODO: Remove this workaround after upgrading to Vagrant 1.3.X
# When running `vagrant plugin install vagrant-berkshelf` there is a problem
# with pulling in nokogiri. It fails during the build.

execute "install nokogiri" do
  command 'gem install nokogiri --no-rdoc --no-ri --install-dir /var/lib/jenkins/.vagrant.d/gems'
  user 'jenkins'
  environment(
    'GEM_PATH' => '/var/lib/jenkins/.vagrant.d/gems'
  )
  not_if { ::Kernel.system("GEM_PATH=/var/lib/jenkins/.vagrant.d/gems gem list | grep nokogiri") }
end

node['rs-cookbooks_ci']['vagrant']['plugins'].each do |plug_name|
  vagrant_plugin plug_name do
    user 'jenkins'
  end
end
