#
# Cookbook Name:: windows_activedirectory
# Recipe:: gpo_CtxStartMenu
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
powershell_script "CtxStartMenuTaskBar" do
  code <<-EOH
  #Define Group Policy Name
  $GP_NAME = "CTX_StartMenuTaskBar"
  #Get date/time information
  $date = Get-Date -DisplayHint Date -Format ddMMMyyy
  $time = get-date -displayhint time -format hh-mm-ss
  #Begin recording output
  start-transcript -path ($home + "\\" + $GP_NAME + "_Script_" + $date + $time + ".txt")
  import-module grouppolicy
  # Create new group policy object
  New-GPO -name $GP_NAME
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Runonce"  -ValueName CtxDesktopExperienceUser -Type String -Value ('%SystemRoot%\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy AllSigned -WindowStyle Hidden -File "%windir%\\ProgramFiles (x86)\\Citrix\\App Delivery Setup Tools\\Enable-CtxDesktopExperienceUser.ps1"')
  #output htm of GPO
  get-gporeport $gp_name -reporttype html -path ($home + "\\" + $gp_name + ".html")
  Stop-Transcript
  Clear
  write-host ($GP_NAME + ".htm") exported to $home
  EOH
  not_if {::File.exists?(node['sm']['file'])}
  not_if {reboot_pending?}
end

windows_reboot 30 do
  reason 'A System Restart has been requested. Rebooting now..'
  only_if {reboot_pending?}
end