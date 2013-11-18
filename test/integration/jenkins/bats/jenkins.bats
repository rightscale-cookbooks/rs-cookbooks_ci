#!/usr/bin/env bats

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
