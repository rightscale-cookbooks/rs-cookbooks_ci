include_recipe "git"

git_config = "/var/lib/jenkins/hudson.plugins.git.GitSCM.xml"
git_username = "davidv-vo"
git_email = "david.vo@rightscale.com"

template git_config do
  source 'git_config.xml.erb'
  mode 0644
  variables({
    :git_username => git_username,
    :git_email => git_email
  })
end
