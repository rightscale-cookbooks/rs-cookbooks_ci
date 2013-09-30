name             'rs-cookbooks-ci'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-cookbooks-ci'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.1.0'

depends "apt", "~> 2.1.1"
depends "ruby", "~> 0.9.2"
#depends "jenkins", "~> 1.0.0"
depends "jenkins"
depends "vagrant", "~> 0.2.0"
depends "virtualbox", "~> 1.0.0"
depends "git", "~> 2.6.0"