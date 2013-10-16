#!/usr/bin/env bats

@test " vagrant installed." {

vagrant -v | grep 1.2.7 

}

@test "berkshelf installed." {

sudo -i -u  jenkins vagrant plugin list | grep vagrant-berkshelf

}

@test "Check the omnibus plugin for Vagrant." {

sudo -i -u  jenkins vagrant plugin list | grep vagrant-omnibus

} 

@test "check the bindlwe plugin for vagrant" {

sudo -i -u jenkins vagrant plugin list | grep bindler

}

@test "ruby installed." { 

ruby -v | grep 1.9.3

}

@test "check jenkins running." {

service jenkins status | grep "is running"
 

}

@test "jenkins user/group is created " {

grep "jenkins" /etc/passwd
grep "jenkins" /etc/group

}
 
@test "vitrualbox is installed" {

dpkg -l | grep virtualbox

}


