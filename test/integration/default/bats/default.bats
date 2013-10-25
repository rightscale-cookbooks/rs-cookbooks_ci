#!/usr/bin/env bats

#
# check that vagrant is installed and grep the correct version
#
@test "Check that Vagrant is installed" {
  which vagrant 
}

@test "check the correct version for vagrant" {
  vagrant --version | grep 1.2.7
}

#
# check that vagrant plugin is installed vagrant-berrkshelf, vagrant-omnibus, bindler
#
@test "Check that the vagrant-berkshelf plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep vagrant-berkshelf
}

@test "Check that the vagrant-omnibus plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep vagrant-omnibus
}

@test "Check that the bindler plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep bindler
} 

#
# check that ruby is installed and grep the correct version
#
@test "Check that Ruby is installed" {
  which ruby
}

@test "check correct version of ruby" {
  ruby -v | grep 1.9.3
}

#
# check that jenkins is installed
#
@test "Check that the jenkins service running" {
  service jenkins status | grep "is running"
}

#
# check that jenkins user and group are created
#
@test "Check that the jenkins user was created" {
  grep "jenkins" /etc/passwd
}

@test "check that jenkins group was created" {
  grep "jenkins" /etc/group
}

#
# check that virtualbox is installed
#
@test "Check that virtualbox is installed" {
  which virtualbox
}

#
# check that git is installed and reped the correct version 
#
@test "check that git is installed" {
  which git
}

@test "check the correct version of git" {
  git --version
}

