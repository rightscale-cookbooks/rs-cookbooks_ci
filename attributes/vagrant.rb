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

default['rs-cookbooks_ci']['vagrant']['url'] = 'http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb'
default['rs-cookbooks_ci']['vagrant']['checksum'] = 'db7d06f46e801523d97b6e344ea0e4fe942f630cc20ab1706e4c996872f8cd71'

default['rs-cookbooks_ci']['vagrant']['plugins'] = ['vagrant-berkshelf', 'vagrant-omnibus', 'bindler']
