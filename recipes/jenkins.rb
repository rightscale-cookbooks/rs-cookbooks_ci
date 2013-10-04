node.override['jenkins']['server']['plugins'] = node['rs-cookbooks-ci']['jenkins']['server']['plugins']

include_recipe "jenkins::server"

#Hash of jobs
jobs = {
  "marker" => {
    'git_repo' => "git://github.com/rightscale-cookbooks/marker.git",
    "git_branch" => "master"
  },
  "myface" => {
    'git_repo' => "git://github.com/amashhour/myface.git",
    'git_branch' => "master"
  }
}

#Iterate through jobs and create a config file for each job.
jobs.each do |job_name, job_config|

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




