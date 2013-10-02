node.override['jenkins']['server']['plugins'] = node['rs-cookbooks-ci']['jenkins']['server']['plugins']

include_recipe "jenkins::server"