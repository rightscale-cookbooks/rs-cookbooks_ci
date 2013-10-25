name             'rs-cookbooks_ci'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-cookbooks_ci'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.1.0'

supports "ubuntu"

depends "apt", "~> 2.1.1"
depends "xml"
depends "build-essential"
depends "ruby", "~> 0.9.2"
depends "jenkins"
depends "vagrant", "~> 0.2.0"
depends "virtualbox", "~> 1.0.0"
depends "git", "~> 2.6.0"

recipe "rs-cookbooks_ci::default",
  "Default recipe to install rs-cookbooks_ci"
recipe "rs-cookbooks_ci::apt",
  "Executes apt-get update to ensure the local package cache is up to date"
recipe "rs-cookbooks_ci::xml",
  "Installs development packages for libxml"
recipe "rs-cookbooks_ci::build-essentials",
  "Installs compile tools to help with bcrypt-ruby gem required by users recipe in Jenkins cookbook"
recipe "rs-cookbooks_ci::ruby",
    "Installs ruby"
recipe "rs-cookbooks_ci::jenkins",
  "Installs Jenkins, required plugins, and sets up jobs"
recipe "rs-cookbooks_ci::vagrant",
  "Installs Vagrant and required plugins"
recipe "rs-cookbooks_ci::virtualbox",
  "Installs Virtualbox"
recipe "rs-cookbooks_ci::git",
  "Installs Git"

attribute "rs-cookbooks_ci/languages/ruby/default_version",
  :display_name => "Ruby Default Version",
  :description => "The default version of Ruby to be installed",
  :required => "recommended",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::ruby"
    ],
  :default => "1.9.1"

attribute "rs-cookbooks_ci/jenkins/server/plugins",
  :display_name => "Jenkins Plugins",
  :description => "Jenkins plugins to be installed initially",
  :required => "required",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
    ],
  :default => [
    "vagrant-berkshelf",
    "vagrant-omnibus",
    "bindler"
   ]

attribute "rs-cookbooks_ci/jenkins/git_setup/git_config",
  :display_name => "Jenkins Git configuration file",
  :description => "Git configuration file that Jenkins uses to read username and password",
  :required => "required",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ],
  :default => '/var/lib/jenkins/hudson.plugins.git.GitSCM.xml'

attribute "rs-cookbooks_ci/jenkins/username",
  :display_name => "Jenkins Username",
  :description => "Username used to login to Jenkins server",
  :required => "required",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ]

attribute "rs-cookbooks_ci/jenkins/password",
  :display_name => "Jenkins Password",
  :description => "Password used to login to Jenkins server",
  :required => "required",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ]

attribute "rs-cookbooks_ci/jenkins/user_full_name",
  :display_name => "Jenkins Full Username",
    :description => "Full username of Jenkins user",
    :required => "required",
    :recipes => [
      "rs-cookbooks_ci::default",
      "rs-cookbooks_ci::jenkins"
    ]

attribute "rs-cookbooks_ci/jenkins/user_email",
  :display_name => "Jenkins User Email Address",
  :description => "Email address of Jenkins user",
  :required => "required",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ]

attribute "rs-cookbooks_ci/jenkins/git_setup/git_username",
  :display_name => "Git username",
  :description => "Git username, required for code checkout",
  :required => "recommended",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ],
  :default => "cookbook-tester"

attribute "rs-cookbooks_ci/jenkins/git_setup/git_email",
  :display_name => "Git user email address",
  :description => "Git email address, required for code checkout",
  :required => "recommended",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ],
  :default => "cookbook-tester@mycompany.com"

attribute "rs-cookbooks_ci/jenkins/vagrant/plugins",
  :display_name => "Vagrant plugin list",
  :description => "Vagrant plugins you want installed",
  :required => "required",
  :type => "array",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::vagrant"
  ],
  :default => [
    "vagrant-berkshelf",
    "vagrant-omnibus",
    "bindler"
  ]
