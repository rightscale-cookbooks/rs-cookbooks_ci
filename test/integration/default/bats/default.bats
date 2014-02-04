#!/usr/bin/env bats

# Check that vagrant version 1.2.7 is installed

@test "Check that Vagrant is installed" {
  which vagrant
}

@test "Check that the correct version for vagrant is installed" {
  vagrant --version | grep '1\.4\.3'
}

@test "Check that the correct version of virtualbox is installed" {
  vboxmanage --version | grep '^4\.3'
}

# Check that Ruby v1.9.3 is installed

@test "Check that Ruby is installed" {
  which ruby
}

@test "Check that the correct version of ruby is installed" {
  ruby -v | grep '1\.9\.3'
}

# Check that the jenkins service is running

@test "Check that the jenkins service running" {
  service jenkins status
}

# Check that the jenkins user and group exist

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

# Check that git is installed

@test "Check that git is installed" {
  which git
}
