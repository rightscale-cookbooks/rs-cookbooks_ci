#!/usr/bin/env bats

@test " vagrant installed." {

vagrant -v | grep 1.2.7 

}

@test "berkshelf installed." {

vagrant plugin list | grep vagrant-berkshelf

}

@test "Check the omnibus plugin for Vagrant." {

vagrant plugin list | grep vagrant-omnibus

} 

@test "ruby installed." { 

ruby -v | grep 1.9.3

}

@test "check jenkins running." {

service jenkins status

}

