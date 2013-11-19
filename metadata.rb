name             'rs-cookbooks_ci'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-cookbooks_ci'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.1.0'

supports "ubuntu"

depends "apt", "~> 2.3.0"
depends "xml", "~> 1.2.0"
depends "build-essential"
depends "ruby", "~> 0.9.0"
depends "jenkins", "~> 1.2.0"
depends "vagrant", "~> 0.2.0"
depends "virtualbox", "~> 1.0.0"
depends "git", "~> 2.7.0"

recipe "rs-cookbooks_ci::default",
  "Default recipe to install rs-cookbooks_ci"
recipe "rs-cookbooks_ci::build-essential",
  "Installs compile tools to help with bcrypt-ruby gem required by users recipe in Jenkins cookbook"
recipe "rs-cookbooks_ci::ruby",
    "Installs ruby"
recipe "rs-cookbooks_ci::jenkins",
  "Installs Jenkins, required plugins, and sets up jobs"
recipe "rs-cookbooks_ci::vagrant",
  "Installs Vagrant and required plugins"

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
    :required => "recommended",
    :recipes => [
      "rs-cookbooks_ci::default",
      "rs-cookbooks_ci::jenkins"
    ]

attribute "rs-cookbooks_ci/jenkins/user_email",
  :display_name => "Jenkins User Email Address",
  :description => "Email address of Jenkins user",
  :required => "recommended",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ]

attribute "rs-cookbooks_ci/jenkins/git_setup/username",
  :display_name => "Git username",
  :description => "Git username, required for code checkout",
  :required => "required",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ]

attribute "rs-cookbooks_ci/jenkins/git_setup/email",
  :display_name => "Git user email address",
  :description => "Git email address, required for code checkout",
  :required => "required",
  :recipes => [
    "rs-cookbooks_ci::default",
    "rs-cookbooks_ci::jenkins"
  ]
