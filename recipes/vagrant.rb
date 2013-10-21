node.override['vagrant']['url'] = node['rs-cookbooks_ci']['vagrant']['url']
node.override['vagrant']['checksum'] = node['rs-cookbooks_ci']['vagrant']['checksum']

include_recipe "vagrant"

# TODO: Remove this workaround after upgrading to Vagrant 1.3.X
# When running `vagrant plugin install vagrant-berkshelf` there is a problem
# with pulling in nokogiri. It fails during the build error.
#
execute "gem install nokogiri --install-dir /var/lib/jenkins/.vagrant.d/gems" do
  user 'jenkins'
end

node['rs-cookbooks_ci']['vagrant']['plugins'].each do |plug_name|
  vagrant_plugin plug_name do
    user 'jenkins'
  end
end


