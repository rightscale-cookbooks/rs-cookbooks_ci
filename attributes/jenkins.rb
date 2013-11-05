#jenkins

# Specify that jenkins should install using the war method

default['rs-cookbooks_ci']['jenkins']['server']['version'] = '1.537'
default['rs-cookbooks_ci']['jenkins']['server']['install_method'] = 'war'

# Specifies list of Jenkins plugins installed during initial deployment, not including anything that is bundled, but
# including dependencies.
default['rs-cookbooks_ci']['jenkins']['server']['plugins'] = [
  "scm-api",
  "ssh-agent",
  "git-client",
  "github-api",
  "git",
  "github",
  "ansicolor"
]

# Specifies path of configuration file created when a user sets a Git username and email. This is required by the
# Jenkins Git plugin to operate. This file is created automatically by a template.
default['rs-cookbooks_ci']['jenkins']['git_setup']['config_file'] = '/var/lib/jenkins/hudson.plugins.git.GitSCM.xml'
