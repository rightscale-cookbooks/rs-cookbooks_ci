name             'rs-cookbooks-ci'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-cookbooks-ci'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.1.0'

supports "ubuntu"

depends "apt", "~> 2.1.1"
depends "ruby", "~> 0.9.2"
depends "jenkins"
depends "vagrant", "~> 0.2.0"
depends "virtualbox", "~> 1.0.0"
depends "git", "~> 2.6.0"
depends "xml"

recipe "rs-cookbooks-ci::jenkins",
  "Installs Jenkins, required plugins, and sets up jobs"
recipe "rs-cookbooks-ci::ruby",
  "Installs ruby"
recipe "rs-cookbooks-ci::vagrant",
  "Installs Vagrant and required plugins"

attribute "rs-cookbooks-ci/languages/ruby/default_version",
  :display_name => "Ruby Default Version",
  :description => "The default version of Ruby to be installed",
  :required => "required",
  :recipes => [
    "rs-cookbooks-ci::default",
    "rs-cookbooks-ci::ruby"
    ],
  :default => "1.9.1"

attribute "rs-cookbooks-ci/jenkins/server/plugins",
  :display_name => "Jenkins Plugins",
  :description => "Jenkins plugins to be installed initially",
  :required => "required",
  :recipes => [
    "rs-cookbooks-ci::default",
    "rs-cookbooks-ci::jenkins"
    ]

attribute "rs-cookbooks-ci/jenkins/username",
  :display_name => "Jenkins Username",
  :description => "Username used to login to Jenkins server",
  :required => "recommended",
  :recipes => [
    "rs-cookbooks-ci::default",
    "rs-cookbooks-ci::jenkins"
  ]

attribute "rs-cookbooks-ci/jenkins/password",
  :display_name => "Jenkins Password",
  :description => "Password used to login to Jenkins server",
  :required => "recommended",
  :recipes => [
    "rs-cookbooks-ci::default",
    "rs-cookbooks-ci::jenkins"
  ]

attribute "rs-cookbooks-ci/jenkins/user_full_name",
  :display_name => "Jenkins Full Username",
    :description => "Full username of Jenkins user",
    :required => "optional",
    :recipes => [
      "rs-cookbooks-ci::default",
      "rs-cookbooks-ci::jenkins"
    ]

attribute "rs-cookbooks-ci/jenkins/user_email",
  :display_name => "Jenkins User Email Address",
  :description => "Email address of Jenkins user",
  :required => "optional",
  :recipes => [
    "rs-cookbooks-ci::default",
    "rs-cookbooks-ci::jenkins"
  ]

attribute "rs-cookbooks-ci/jenkins/git_setup/git_username",
  :display_name => "Git username",
  :description => "Git username, required for code checkout",
  :required => "required",
  :recipes => [
    "rs-cookbooks-ci::default",
    "rs-cookbooks-ci::jenkins"
  ],
  :default => "cookbook-tester"

attribute "rs-cookbooks-ci/jenkins/git_setup/git_email",
  :display_name => "Git user email address",
  :description => "Git email address, required for code checkout",
  :required => "required",
  :recipes => [
    "rs-cookbooks-ci::default",
    "rs-cookbooks-ci::jenkins"
  ],
  :default => "cookbook-tester@mycompany.com"

attribute "rs-cookbooks-ci/jenkins/vagrant/plugins",
  :display_name => "Vagrant plugin list",
  :description => "Vagrant plugins you want installed",
  :required => "required",
  :type => "array",
  :recipes => [
    "rs-cookbooks-ci::default",
    "rs-cookbooks-ci::vagrant"
  ],
  :default => [
    "vagrant-berkshelf",
    "vagrant-omnibus"
  ]
