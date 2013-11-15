#
# Cookbook Name:: rs-cookbooks_ci
# Attributes:: vagrant
#
# Copyright (C) 2013 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['rs-cookbooks_ci']['vagrant']['url'] = "http://files.vagrantup.com/packages/7ec0ee1d00a916f80b109a298bab08e391945243/vagrant_1.2.7_x86_64.deb"
default['rs-cookbooks_ci']['vagrant']['checksum'] = '8d0a8eb39635baa6cdb7fc00cc54ee64'

default['rs-cookbooks_ci']['vagrant']['plugins'] = ['vagrant-berkshelf', 'vagrant-omnibus', 'bindler']
