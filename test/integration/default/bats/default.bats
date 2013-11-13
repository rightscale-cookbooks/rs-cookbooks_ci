#!/usr/bin/env bats


# Check that vagrant is installed and it greps the correct version

@test "Check that Vagrant is installed" {
  which vagrant 
}

@test "Check the correct version for vagrant" {
  vagrant --version | grep 1.2.7
}


# Check that vagrant plugin is installed vagrant-berrkshelf, vagrant-omnibus, bindler

@test "Check that the vagrant-berkshelf plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep vagrant-berkshelf
}

@test "Check that the vagrant-omnibus plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep vagrant-omnibus
}

@test "Check that the bindler plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep bindler
} 


# Check that ruby is installed and it greps the correct version

@test "Check that Ruby is installed" {
  which ruby
}

@test "Check correct version of ruby" {
  ruby -v | grep 1.9.3
}


# Check that jenkins is installed

@test "Check that the jenkins service running" {
  service jenkins status | grep "run: jenkins"
}


# Check that jenkins user and group are created

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


# Check that git is installed and it greps the correct version 

@test "Check that git is installed" {
  which git
}

@test "Check the correct version of git" {
  git --version | grep 1.7.9.5
}

