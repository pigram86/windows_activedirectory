#
# Cookbook Name:: windows_activedirectory
# Recipe:: gpo_scep_dhcp_server
#
# Copyright (c) 2014-2015 The Authors, All Rights Reserved.
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
powershell_script "" do
  code <<-EOH
  $date = Get-Date -DisplayHint Date -Format ddMMMyyy
  $time = get-date -displayhint time -format hh-mm-ss
  # Define Group Policy Name
  $GP_NAME = "SCEP-DHCP_Server"
  #Begin recording output
  start-transcript -path ($home + "\\" + $GP_NAME + "_Script_" + $date + $time + ".txt")
  import-module grouppolicy
  # Create new group policy object
  New-GPO -name $GP_NAME
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\*.mdb -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\*.edb -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\*.pat -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\*.log -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\*.jrs -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\*.chk -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\backup\\*.mdb -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\backup\\*.log -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\System32\\DHCP\\backup\\*.chk -Type String -Value 0
  #output htm of GPO
  get-gporeport $gp_name -reporttype html -path ($home + "\\" + $gp_name + ".html")
  Stop-Transcript
  Clear
  write-host ($GP_NAME + ".htm") exported to $home
  EOH
  not_if {::File.exists?(node['scep']['dhcp'])}
  not_if {reboot_pending?}
end
