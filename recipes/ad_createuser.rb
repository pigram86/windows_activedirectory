#
# Cookbook Name:: windows_activedirectory
# Recipe:: ad_createuser
#
# Copyright (C) 2015 Todd Pigram
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
#create User
windows_ad_user "Joe Smith" do
  action :create
  domain_name "contoso.com"
  ou "users"
  options ({ "samid" => "JSmith",
        "upn" => "JSmith@contoso.com",
        "fn" => "Joe",
        "ln" => "Smith",
        "display" => "Smith, Joe",
        "disabled" => "no",
        "pwd" => "Passw0rd"
      })
end