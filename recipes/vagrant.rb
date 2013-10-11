node.override['vagrant']['url'] = node['rs-cookbooks_ci']['vagrant']['url']
node.override['vagrant']['checksum'] = node['rs-cookbooks_ci']['vagrant']['checksum']
node.override['vagrant']['plugins'] = node['rs-cookbooks_ci']['vagrant']['plugins']

include_recipe "vagrant"
