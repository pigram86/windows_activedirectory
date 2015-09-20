#
# Cookbook Name:: windows_activedirectory
# Recipe:: ccpstck_ctxadmin
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
windows_ad_user "Citrix Admin" do
  action :create
  domain_name "ccpstack.local"
  ou "Citrix"
  options ({ "samid" => "ctxadmin",
        "upn" => "ctxadmin@ccpstack.local",
        "fn" => "Citrix",
        "ln" => "Admin",
        "display" => "Admin, Citrix",
        "disabled" => "no",
        "pwd" => "ScoobyDoo1",
        "memberof" => "CN=Domain Admins,CN=Users,DC=ccpstack,DC=local",
        "desc" => "Service Account for Citrix"
      })
end