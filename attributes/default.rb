# ruby
default['rs-cookbooks-ci']['languages']['ruby']['default_version'] = "1.9.1"

# vagrant
default['rs-cookbooks-ci']['vagrant']['url'] = "http://files.vagrantup.com/packages/7ec0ee1d00a916f80b109a298bab08e391945243/vagrant_1.2.7_x86_64.deb"
default['rs-cookbooks-ci']['vagrant']['checksum'] = "7ec0ee1d00a916f80b109a298bab08e391945243"
default['rs-cookbooks-ci']['vagrant']['plugins'] = ["vagrant-berkshelf", "vagrant-omnibus"]

#jenkins
default['rs-cookbooks-ci']['jenkins']['server']['plugins'] = ["ssh-credentials", "ssh-slaves", "ssh-agent","git-client", "github-api","git", "github"]
