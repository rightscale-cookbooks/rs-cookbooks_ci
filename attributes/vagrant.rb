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

default['rs-cookbooks_ci']['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.3_x86_64.deb'
default['rs-cookbooks_ci']['vagrant']['checksum'] = 'dbd06de0f3560e2d046448d627bca0cbb0ee34b036ef605aa87ed20e6ad2684b'

default['rs-cookbooks_ci']['vagrant']['plugins'] = ['vagrant-berkshelf']
