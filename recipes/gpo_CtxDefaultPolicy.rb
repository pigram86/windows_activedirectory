#
# Cookbook Name:: windows_activedirectory
# Recipe:: gpo_CtxDefaultPolicy
#
# Copyright (C) 2014-2015 Todd Pigram, All Rights Reserved
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
powershell_script "CtxDefaultPolicy" do
  code <<-EOH
  # Define Group Policy Name
  $GP_NAME = "CTX_Default_Policy"
  #Get date/time information
  $date = Get-Date -DisplayHint Date -Format ddMMMyyy
  $time = get-date -displayhint time -format hh-mm-ss
  #Begin recording output
  start-transcript -path ($home + "\\" + $GP_NAME + "_Script_" + $date + $time + ".txt")
  import-module grouppolicy
  # Create new group policy object
  New-GPO -name $GP_NAME
  Set-GPRegistryValue -Name $GP_NAME -key  "HKLM\\Software\\Policies\\Microsoft\\Power\\PowerSettings" -Valuename ActivePowerScheme -Type String -Value 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\SQMClient\\Windows" -Valuename CEIPEnable -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\PowerShell" -Valuename EnableScripts -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\PowerShell" -Valuename ExecutionPolicy -Type String -Value RemoteSigned
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\Windows Error Reporting" -Valuename Disabled -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU" -Valuename NoAutoUpdate -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU" -Valuename  "**del.AUOptions","**del.ScheduledInstallDay","**del.ScheduledInstallTime" -Type String -Value "","",""
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Client" -Valuename TrustedHosts -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Client" -Valuename TrustedHostsList -Type String -Value *
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service" -Valuename AllowAutoConfig -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service" -Valuename "IPv4Filter","IPv6Filter" -Type String  -Value "*","*"
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service\\WinRS" -Valuename MaxMemoryPerShellMB -Type DWORD -Value 1000
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service\\WinRS" -Valuename MaxShellsPerUser -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows NT\\SystemRestore" -Valuename DisableSR -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows NT\\Terminal Services" -Valuename fDisableCpm -Type DWORD -Value 1
  #output htm of GPO
  get-gporeport $gp_name -reporttype html -path ($home + "\\" + $gp_name + ".html")
  Stop-Transcript
  EOH
  not_if {::File.exists?(node['dp']['file'])}
  not_if {reboot_pending?}
end

windows_reboot 30 do
  reason 'A System Restart has been requested. Rebooting now..'
  only_if {reboot_pending?}
end