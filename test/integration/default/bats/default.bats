#!/usr/bin/env bats

@test "Check that Vagrant is installed" {
  vagrant -v | grep 1.2.7
}

@test "Check that the vagrant-berkshelf plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep vagrant-berkshelf
}

@test "Check that the vagrant-omnibus plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep vagrant-omnibus
}

@test "Check that the bindler plugin is installed" {
  sudo -i -u jenkins vagrant plugin list | grep bindler
} 

@test "Check that Ruby is installed" {
  ruby -v | grep 1.9.3
}

@test "Check that the jenkins service running" {
  service jenkins status | grep "is running"
}

@test "Check that the jenkins user/group was created" {
  grep "jenkins" /etc/passwd
  grep "jenkins" /etc/group
}

@test "Check that virtualbox is installed" {
  dpkg -l | grep virtualbox
}

@test "check that git is installed" {
  sudo -i -u jenkins git --version
}

