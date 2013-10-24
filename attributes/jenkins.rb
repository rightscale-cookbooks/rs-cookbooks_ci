#jenkins

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
default['rs-cookbooks_ci']['jenkins']['git_setup']['git_config'] = '/var/lib/jenkins/hudson.plugins.git.GitSCM.xml'
