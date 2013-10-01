node.override['jenkins']['server']['plugins'] = node['rs-cookbooks-ci']['jenkins']['server']['plugins']

include_recipe "jenkins::server"

# jenkins_plugin 'ssh-credentials' do
#   action :install
#   version '1.4'
# end
# 
# jenkins_plugin 'ssh-slaves' do
#   action :install
#   version '1.2'
# end

git_branch = 'master'
job_name = "marker"

job_config = File.join(node[:jenkins][:node][:home], "marker-master-config.xml")

jenkins_job job_name do
  action :create
  config job_config
end

template job_config do
  source    'job_config.xml.erb'
  variables :job_name => job_name, :branch => git_branch, :node => node[:fqdn]
  notifies  :update, resources(:jenkins_job => job_name), :immediately
  notifies  :build, resources(:jenkins_job => job_name), :immediately
end