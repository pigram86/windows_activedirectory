#
# Cookbook Name:: windows_activedirectory
# Recipe:: daas_tenants
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

# Create Organizational Unit "Citrix" in the root
windows_ad_ou "Tenants" do
  action :create
  domain_name "daas.local"
end

windows_ad_ou "Nasdaq" do
  action :create
  domain_name "daas.local"
  ou "Tenants"
end

windows_ad_ou "CloudApps" do
  action :create
  domain_name "daas.local"
  ou "Tenants"
end