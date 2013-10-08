node.override['jenkins']['server']['plugins'] = node['rs-cookbooks-ci']['jenkins']['server']['plugins']

include_recipe "jenkins::server"

#Iterate through jobs and create a config file for each job.
node[:"rs-cookbooks-ci"][:jenkins][:jobs].each do |job_name, job_config|

  jenkins_job job_name do
    action :nothing
    config "/tmp/#{job_name}.xml"
  end

  template "/tmp/#{job_name}.xml" do
    source 'job_config.xml.erb'
    mode 0644
    variables({
      :git_repo => job_config["git_repo"],
      :git_branch => job_config["git_branch"]
    })
    notifies  :update, resources(:jenkins_job => job_name), :immediately
  end

end

#Create Git credentials
template node[:"rs-cookbooks-ci"][:jenkins][:git_setup][:git_config] do
  source 'git_config.xml.erb'
  owner 'jenkins'
  group 'jenkins'
  mode 0644
  variables({
    :git_username => node[:"rs-cookbooks-ci"][:jenkins][:git_setup][:git_username],
    :git_email => node[:"rs-cookbooks-ci"][:jenkins][:git_setup][:git_email]
  })
end
