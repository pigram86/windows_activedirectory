#
# Cookbook Name:: windows_activedirectory
# Recipe:: default
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
#
# Steup for MS Active Directory
if node[:os_version] >= "6.2"
  %w{ DNS-Server-Full-Role DNS-Server-Tools ActiveDirectory-Powershell DirectoryServices-DomainController-Tools DirectoryServices-AdministrativeCenter DirectoryServices-DomainController }.each do |feature|
    windows_feature feature do
      action :install
    end
  end
else
  [ "NetFx3", "Microsoft-Windows-GroupPolicy-ServerAdminTools-Update", "DirectoryServices-DomainController" ].each do |feature|
    windows_feature feature do
      action :install
    end
  end
  Chef::Log.error("This version of Windows Server is currently unsupported beyond installing the required roles and features")
  not_if {reboot_pending?}
end


windows_reboot 30 do
  reason "A System Restart has been requested. Rebooting now.."
  only_if {reboot_pending?}
end