node.override['jenkins']['server']['plugins'] = node['rs-cookbooks_ci']['jenkins']['server']['plugins']

# Add overrides for Jenkins username and password for login
node.override['jenkins']['username'] = node['rs-cookbooks_ci']['jenkins']['username']
node.override['jenkins']['password'] = node['rs-cookbooks_ci']['jenkins']['password']
node.override['jenkins']['user_full_name'] = node['rs-cookbooks_ci']['jenkins']['user_full_name']
node.override['jenkins']['user_email'] = node['rs-cookbooks_ci']['jenkins']['user_email']

include_recipe "jenkins::server"

# Iterate through jobs and create a config file for each job. Store this file in Jenkins.
node['rs-cookbooks_ci']['jenkins']['jobs'].each do |job_name, job_config|

  jenkins_job job_name do
    action :nothing
    config "/tmp/#{job_name}.xml"
  end

  template "/tmp/#{job_name}.xml" do
    source 'job_config.xml.erb'
    mode 0644
    variables({
      :git_repo => job_config['git_repo'],
      :git_branch => job_config['git_branch']
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
