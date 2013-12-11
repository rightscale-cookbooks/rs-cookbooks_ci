#
# Cookbook Name:: rs-cookbooks_ci
# Attributes:: jenkins
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

# Specify that jenkins should install using the war method which allows us to specify the version number. There is a
# defect with the package method which does not respect a user-specified version

default['rs-cookbooks_ci']['jenkins']['server']['version'] = '1.540'
default['rs-cookbooks_ci']['jenkins']['server']['install_method'] = 'war'

# Specifies list of Jenkins plugins installed during initial deployment, not including anything that is bundled, but
# including dependencies.
default['rs-cookbooks_ci']['jenkins']['server']['plugins'] = [
  'scm-api',
  'ssh-agent',
  'git-client',
  'github-api',
  'git',
  'github',
  'ansicolor',
  'ghprb'
]

# Specifies path of configuration file created when a user sets a Git username and email. This is required by the
# Jenkins Git plugin to operate. This file is created automatically by a template.
default['rs-cookbooks_ci']['jenkins']['config']['git_config']['config_file'] =
  "#{node['jenkins']['server']['home']}/hudson.plugins.git.GitSCM.xml"
default['rs-cookbooks_ci']['jenkins']['config']['jenkins_location']['config_file'] =
  "#{node['jenkins']['server']['home']}/jenkins.model.JenkinsLocationConfiguration.xml"
default['rs-cookbooks_ci']['jenkins']['config']['ghprb']['config_file'] =
  "#{node['jenkins']['server']['home']}/org.jenkinsci.plugins.ghprb.GhprbTrigger.xml"
  default['rs-cookbooks_ci']['jenkins']['config']['webhook']['config_file'] =
    "#{node['jenkins']['server']['home']}/com.cloudbees.jenkins.GitHubPushTrigger.xml"

# Specifies the values we want to override in the ghprb plugin configuration.
default['rs-cookbooks_ci']['jenkins']['config']['ghprb']['customizations'] = {
  'accessToken' => node['rs-cookbooks_ci']['jenkins']['config']['ghprb']['token'],
  'adminlist' => node['rs-cookbooks_ci']['jenkins']['config']['ghprb']['admins'].join(' '),
  'cron' => nil
}
