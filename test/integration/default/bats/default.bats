#!/usr/bin/env bats


# Check that vagrant version 1.2.7 is installed

@test "Check that Vagrant is installed" {
  which vagrant
}

@test "Check the correct version for vagrant" {
  vagrant --version | grep 1\.2\.7
}


# Check that the following vagrant plugins are installed: vagrant-berkshelf, vagrant-omnibus, bindler

@test "Check that the vagrant-berkshelf plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep vagrant-berkshelf
}

@test "Check that the vagrant-omnibus plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep vagrant-omnibus
}

@test "Check that the bindler plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep bindler
}


# Check that Ruby v1.9.3 is installed

@test "Check that Ruby is installed" {
  which ruby
}

@test "Check correct version of ruby" {
  ruby -v | grep 1\.9\.3
}


# Check that the jenkins service is running

@test "Check that the jenkins service running" {
  service jenkins status | grep "run: jenkins"
}


# Check taht the jenkins user and group exist

@test "Check that the jenkins user was created" {
  grep "jenkins" /etc/passwd
}

@test "Check that jenkins group was created" {
  grep "jenkins" /etc/group
}


# Check that virtualbox is installed

@test "Check that virtualbox is installed" {
  which virtualbox
}


# Check that git v1.7.9.5 is installed

@test "Check that git is installed" {
  which git
}
