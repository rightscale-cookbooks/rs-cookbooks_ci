node.override['vagrant']['url'] = node['rs-cookbooks_ci']['vagrant']['url']
node.override['vagrant']['checksum'] = node['rs-cookbooks_ci']['vagrant']['checksum']

include_recipe "vagrant"

node['rs-cookbooks_ci']['vagrant']['plugins'].each do |plug_name|
  vagrant_plugin plug_name do
    user 'jenkins'
  end
end


