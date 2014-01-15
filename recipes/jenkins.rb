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

node.override['build_essential']['compiletime'] = true

include_recipe 'build-essential'
include_recipe 'ruby::1.9.1'

node.override['jenkins']['server']['plugins'] = node['rs-cookbooks_ci']['jenkins']['server']['plugins']

# Add overrides for Jenkins username and password for login
node.override['jenkins']['username'] = node['rs-cookbooks_ci']['jenkins']['username']
node.override['jenkins']['password'] = node['rs-cookbooks_ci']['jenkins']['password']
node.override['jenkins']['user_full_name'] = node['rs-cookbooks_ci']['jenkins']['user_full_name']
node.override['jenkins']['user_email'] = node['rs-cookbooks_ci']['jenkins']['user_email']

include_recipe 'jenkins::server'

node.override['virtualbox']['version'] = '4.3'

# This uses the jenkins_job resource to create jobs using a template. For each job, it creates a temporary config
# file then populates it using a template (.erb) which is filled out with variables stored in attributes
# Initially the job doesn't do anything when it is defined (hence action :nothing). It only kicks off once it is
# notified by the template.

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
      :git_project_url => job_config['git_project_url'],
      # We want to make sure the admins list is added for each job
      :job_admins_list => node['rs-cookbooks_ci']['jenkins']['config']['ghprb']['admins'].join(' ')
    })
    notifies :update, "jenkins_job[#{job_name}]", :immediately
  end

end

# Create Git credentials using a template and store it as a config file in the Jenkins root
template node['rs-cookbooks_ci']['jenkins']['config']['git_config']['config_file'] do
  source 'git_config.xml.erb'
  owner node['rs-cookbooks_ci']['jenkins']['server']['user']
  group node['rs-cookbooks_ci']['jenkins']['server']['group']
  mode 0644
  variables({
    :git_username => node['rs-cookbooks_ci']['jenkins']['config']['git_setup']['username'],
    :git_email => node['rs-cookbooks_ci']['jenkins']['config']['git_setup']['email']
  })
end

# Specify the Jenkins url and email using a template and store it as a config file in the Jenkins root
template node['rs-cookbooks_ci']['jenkins']['config']['jenkins_location']['config_file'] do
  source 'jenkins.model.JenkinsLocationConfiguration.xml.erb'
  owner node['rs-cookbooks_ci']['jenkins']['server']['user']
  group node['rs-cookbooks_ci']['jenkins']['server']['group']
  mode 0644
  variables({
    :jenkins_url => node['rs-cookbooks_ci']['jenkins']['config']['jenkins_location']['url'],
    :jenkins_admin_email => node['rs-cookbooks_ci']['jenkins']['config']['jenkins_location']['email']
  })
end

# Create the GitHub Pull Request Builder configuration file in jenkins root if it doesn't exist. The action is
# important because we don't want to overwrite the file each time we converge. Also, this xml file is unusual in that
# it is used for both configuration and data storage so overwriting this file will wipe out any saved data.
cookbook_file 'org.jenkinsci.plugins.ghprb.GhprbTrigger.xml' do
  path node['rs-cookbooks_ci']['jenkins']['config']['ghprb']['config_file']
  owner node['rs-cookbooks_ci']['jenkins']['server']['user']
  group node['rs-cookbooks_ci']['jenkins']['server']['group']
  action :create_if_missing
end

# Checks the 'customizations' hash to see what lines we want to replace in the GitHub Pull Request Builder configuration
# If we want to clear the values from a key, we are setting it as nil. Otherwise we set what we want the new value to
# be and this automatically replaces it, adding in the approriate brackets and spacing.
node['rs-cookbooks_ci']['jenkins']['config']['ghprb']['customizations'].each do |key, value|
  new_value =
    if value.nil?
      "  <#{key}/>"
    else
      "  <#{key}>#{value}</#{key}>"
    end
  replace_or_add "#{key} -> #{value}" do
    path node['rs-cookbooks_ci']['jenkins']['config']['ghprb']['config_file']
    pattern "^\s+<#{key}"
    line new_value
  end
end

# Allow the GitHub Web Hooks to be managed automatically
template node['rs-cookbooks_ci']['jenkins']['config']['webhook']['config_file'] do
  source 'com.cloudbees.jenkins.GitHubPushTrigger.xml.erb'
  owner node['rs-cookbooks_ci']['jenkins']['server']['user']
  group node['rs-cookbooks_ci']['jenkins']['server']['group']
  mode 0644
  variables({
    :bot_username => node['rs-cookbooks_ci']['jenkins']['config']['webhook']['bot_username'],
    :bot_token => node['rs-cookbooks_ci']['jenkins']['config']['ghprb']['token']
  })
end
