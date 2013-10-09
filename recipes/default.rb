#
# Cookbook Name:: rs-cookbooks-ci
# Recipe:: default
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

include_recipe "apt"
include_recipe "rs-cookbooks-ci::ruby"
include_recipe "rs-cookbooks-ci::jenkins"
include_recipe "rs-cookbooks-ci::vagrant"
include_recipe "virtualbox"
include_recipe "git"
include_recipe "xml"

gem_package "bundler"




#user "qaadmin" do
#  group "adm"
#  system true
#  shell "/bin/bash"
#end



