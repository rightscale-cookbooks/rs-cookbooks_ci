#jenkins
default['rs-cookbooks_ci']['jenkins']['server']['plugins'] = [
  "scm-api",
  "ssh-agent",
  "git-client",
  "github-api",
  "git",
  "github",
  "ansicolor"
]

default['rs-cookbooks_ci']['jenkins']['git_setup']['git_config'] = '/var/lib/jenkins/hudson.plugins.git.GitSCM.xml'
