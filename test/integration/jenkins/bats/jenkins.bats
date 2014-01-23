#!/usr/bin/env bats

# Check that the jenkins service is running

@test "Temporary test to get CI to build on merge branch. Remove when done" {
  service jenkins status
}


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

# Check that the Git config file is created and configured correctly

@test "Check that the Git config file is created" {
  test -f "/var/lib/jenkins/hudson.plugins.git.GitSCM.xml"
}

@test "Check that the specified Git username is in the config file" {
  grep  "rightscale-cookbooks-jenkins" /var/lib/jenkins/hudson.plugins.git.GitSCM.xml
}

@test "Check that the specified Git email is in the config file" {
  grep  "cookbooks@rightscale.com" /var/lib/jenkins/hudson.plugins.git.GitSCM.xml
}

# Check that the Jenkins location config is created and configured correctly

@test "Check that the Jenkins location config file is created" {
  test -f "/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml"
}

@test "Check that the specified Jenkins url is in the config file" {
  grep  "http://33.33.33.10:8080/" /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml
}

@test "Check that the specified Jenkins email is in the config file" {
  grep  "name@mycompany.com" /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml
}

# Check that the GitHub Pull Request builder config file is created and configured correctly

@test "Check that the GitHub Pull Request Builder config file is created" {
  test -f "/var/lib/jenkins/org.jenkinsci.plugins.ghprb.GhprbTrigger.xml"
}

@test "Check that the admins list is in the config file" {
  grep  "<adminlist>test-admin1 test-admin2 test-admin3</adminlist>" /var/lib/jenkins/org.jenkinsci.plugins.ghprb.GhprbTrigger.xml
}

@test "Check that the cron field is emptied" {
  grep  "<cron/>" /var/lib/jenkins/org.jenkinsci.plugins.ghprb.GhprbTrigger.xml
}

# Check that the GitHub Push Trigger config file is created and configured correctly

@test "Check that the GitHub Push Trigger config file is created" {
  test -f "/var/lib/jenkins/com.cloudbees.jenkins.GitHubPushTrigger.xml"
}

@test "Check that the specified username is in the config file" {
  grep  "<username>qabot</username>" /var/lib/jenkins/com.cloudbees.jenkins.GitHubPushTrigger.xml
}

@test "Check that the specified token is in the config file" {
  grep  "<oauthAccessToken>thisIsAFakeToken</oauthAccessToken>" /var/lib/jenkins/com.cloudbees.jenkins.GitHubPushTrigger.xml
}

