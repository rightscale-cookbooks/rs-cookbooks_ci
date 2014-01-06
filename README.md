# rs-cookbooks-ci cookbook

[![Build Status](https://travis-ci.org/rightscale-cookbooks/rs-cookbooks_ci.png?branch=master)](https://travis-ci.org/rightscale-cookbooks/rs-cookbooks_ci)

This cookbook providesd recipes to setup a Jenkins build system for the purpose of continuous intgegration (CI) testing of Cookbooks.

Github Repository: [https://github.com/rightscale-cookbooks/rs-cookbooks_ci](https://github.com/rightscale-cookbooks/rs-cookbooks_ci)

# Requirements
* Chef 11 or higher
* Ubuntu installation, preferbly Ubuntu Server v12.04

# Usage
To setup a continuous integration (CI) server, add a depdency to your cookbook's `metadata.rb`

Include `rs-cookbooks_ci::default` in your runlist.

# Attributes
These are attributes used in recipes and templates. Only internal attributes are listed. Default values are provided.

## Jenkins

* `node['rs-cookbooks_ci']['jenkins']['jenkins']['username']` - Username to login to the Jenkins website. Default is `qa`
* `node['rs-cookbooks_ci']['jenkins']['jenkins']['password']` - Password to login to the Jenkins website. Default is `qapass`
* `node['rs-cookbooks_ci']['jenkins']['jenkins']['user_full_name']` - Full name of Jenkins admin. Default is `White Team QA`
* `node['rs-cookbooks_ci']['jenkins']['jenkins']['user_email']` - Email address of Jenkins admin. Default is `whiteqa@rightscale.com`
* `node['rs-cookbooks_ci']['jenkins']['jobs']` - A hash of jobs that you want automatically created in Jenkins with the key being the job name and the value being a hash with job configuration values.
* `node['rs-cookbooks_ci']['jenkins']['jobs']['your_job_name']['git_description']` - A description of the job. Please note that `your_job_name` here is just an example and should be replaced with actual job names
* `node['rs-cookbooks_ci']['jenkins']['jobs']['your_job_name']['git_repo']` - The Git repo for the project you want to test
* `node['rs-cookbooks_ci']['jenkins']['jobs']['your_job_name']['git_project_url']` - The web address of your project on Github
* `node['rs-cookbooks_ci']['jenkins']['git_setup']['username']` - Git username. Can be anything you want; the plugin just requires something
* `node['rs-cookbooks_ci']['jenkins']['git_setup']['email']` - Git email. Can be anything you want; the plugin just requires something
* `node['rs-cookbooks_ci']['config']['jenkins_location']['url']` - The url for Jenkins
* `node['rs-cookbooks_ci']['config']['jenkins_location']['email']` - The email address for the System Admin for Jenkins
* `node['rs-cookbooks_ci']['config']['ghprb']['token']` - The GitHub Access Token for your account. This should belong to a "bot" that you setup on GitHub. It is important that you fill in the real value here, replacing the placeholder
* `node['rs-cookbooks_ci']['config']['ghprb']['admins']` - Space seperated list of whitelisted admins. Builds will auatomatically launch for any committs or Pull Requests made by a GitHub user on this list
* `node['rs-cookbooks_ci']['config']['webhook']['bot_username']` - The username for the GitHub user that is tied to the webhook which watches for commmits. Default is `qabot`
* `node['rs-cookbooks-ci']['jenkins']['server']['version']` - Specifies the version of Jenkins to be installed. Default is `'1.540'`
* `node['rs-cookbooks-ci']['jenkins']['server']['install_method']` - Specifies the install method to be used to install Jenkins. Default is `'war'`
* `node['rs-cookbooks-ci']['jenkins']['server']['plugins']` - Specifies the version of Jenkins to be installed. Default is `'[scm-api','ssh-agent','git-client','github-api','git','github','ansicolor','ghprb']'`
* `node['rs-cookbooks_ci']['jenkins']['config']['git_config']['config_file']` = The path and filename for the config file for the Jenkins Git plugin. Default is `#{node['jenkins']['server']['home']}/hudson.plugins.git.GitSCM.xml`
* `node['rs-cookbooks_ci']['jenkins']['config']['jenkins_location']['config_file']`= The path and filename for the config file for the Jenkins location. Default is `#{node['jenkins']['server']['home']}/jenkins.model.JenkinsLocationConfiguration.xml`
* `node['rs-cookbooks_ci']['jenkins']['config']['ghprb']['config_file']` = The path and filename for the config file for abc. Default is `#{node['jenkins']['server']['home']}/org.jenkinsci.plugins.ghprb.GhprbTrigger.xml`
* `node['rs-cookbooks_ci']['jenkins']['config']['webhook']['config_file']` = The path and filename for the config file to specify how webhooks should be managed. Default is `#{node['jenkins']['server']['home']}/com.cloudbees.jenkins.GitHubPushTrigger.xml`

## Vagrant
* `node['rs-cookbooks-ci']['vagrant']['plugins']` - The Vagrant plugins we require to run our CI system. Default is `['vagrant-berkshelf', 'vagrant-omnibus', 'bindler']`


# Recipes
## rs-cookbooks_ci::default

All-in-one recipe to run all the recipes in rs-cookbooks_ci cookbook.

## rs-cookbooks_ci::jenkins
Installs and sets up `Jenkins` as well as `Ruby` and `build-eseential`

## rs-cookbooks_ci::vagrant
Installs ands sets up `vagrant`, which is used to deploy VM environments for cookbook testing

# Templates
* `git_config.xml.erb` - Configures the Git plugin for Jenkins
* `job_config.xml.erb` - Configures the Jenkins jobs

# Files
* `org.jenkinsci.plugins.ghprb.GhprbTrigger.xml` - Configures the GitHub Pull Request Builder plugin for Jenkins

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)
