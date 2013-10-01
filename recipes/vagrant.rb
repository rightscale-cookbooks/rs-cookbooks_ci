node.override['vagrant']['url']      = node['rs-cookbooks-ci']['vagrant']['url']
node.override['vagrant']['checksum'] = node['rs-cookbooks-ci']['vagrant']['checksum']
node.override['vagrant']['plugins']  = node['rs-cookbooks-ci']['vagrant']['plugins'] 

include_recipe "vagrant"