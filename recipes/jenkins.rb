#
# Cookbook Name:: rs-cookbooks_ci
# Recipe:: jenkins
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

# node.override['jenkins']['server']['version'] = node['rs-cookbooks_ci']['jenkins']['server']['version']
# node.override['jenkins']['server']['install_method'] = node['rs-cookbooks_ci']['jenkins']['server']['install_method']

node.override['jenkins']['server']['plugins'] = node['rs-cookbooks_ci']['jenkins']['server']['plugins']

# Add overrides for Jenkins username and password for login
node.override['jenkins']['username'] = node['rs-cookbooks_ci']['jenkins']['username']
node.override['jenkins']['password'] = node['rs-cookbooks_ci']['jenkins']['password']
node.override['jenkins']['user_full_name'] = node['rs-cookbooks_ci']['jenkins']['user_full_name']
node.override['jenkins']['user_email'] = node['rs-cookbooks_ci']['jenkins']['user_email']


include_recipe 'build-essential'
include_recipe 'ruby::1.9.1'
include_recipe "jenkins::server"

# This uses the jenkins_job resource to create jobs using a template. For each job, it creates a temporary config
# file then populates it using a template (.erb) which is filled out with variables stored in attributes
# Initially the job doesn't when it is defined (hence action :nothing). It only kicks off once it is notified by the
# template.

node['rs-cookbooks_ci']['jenkins']['jobs'].each do |job_name, job_config|

  jenkins_job job_name do
    action :nothing
    config "/tmp/#{job_name}.xml"
  end

  template "/tmp/#{job_name}.xml" do
    source 'job_config.xml.erb'
    mode 0644
    variables({
      :git_description => job_config['git_description'],
      :git_repo => job_config['git_repo'],
      :git_branch => job_config['git_branch'],
      :git_project_url => job_config['git_project_url']
    })
    notifies :update, "jenkins_job[#{job_name}]", :immediately
  end

end

# Create Git credentials using a template and store it as a config file in the Jenkins root
template node['rs-cookbooks_ci']['jenkins']['git_setup']['config_file'] do
  source 'git_config.xml.erb'
  owner 'jenkins'
  group 'jenkins'
  mode 0644
  variables({
    :git_username => node['rs-cookbooks_ci']['jenkins']['git_setup']['username'],
    :git_email => node['rs-cookbooks_ci']['jenkins']['git_setup']['email']
  })
end
