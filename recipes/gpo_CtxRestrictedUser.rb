#
# Cookbook Name:: windows_activedirectory
# Recipe:: gpo_CtxRestrictedUser
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
powershell_script "CtxRestrictedUser" do
  code <<-EOH
  # Define Group Policy Name
  $GP_NAME = "CTX_RestrictedUser"
  #Get date/time information
  # $date = Get-Date -DisplayHint Date -Format ddMMMyyy
  # $time = get-date -displayhint time -format hh-mm-ss
  #Begin recording output
  start-transcript -path ($home + "\\" + $GP_NAME + "_Script_" + $date + $time + ".txt") 
  import-module grouppolicy
  # Create new group policy object
  New-GPO -name $GP_NAME
  $1 = $env:USERDNSDOMAIN
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName RestrictCpl -Type DWORD -Value 4
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoClose -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoRun -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoWindowsUpdate -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoSMHelp -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoSecurityTab -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoManageMyComputerVerb -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoHardwareTab -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName HideSCANetwork -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName HideSCAHealth -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoPropertiesMyComputer -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoPropertiesRecycleBin -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoThemesTab -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoSetTaskbar -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoStartMenuPinnedList -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" -ValueName NoChangeStartMenu -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 3 -Type String -Value Default Programs
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 4 -Type String -Value Keyboard
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 6 -Type String -Value Sound
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 7 -Type String -Value Text to Speech
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 8 -Type String -Value Ease of Access Center
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 9 -Type String -Value Internet Options
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 10 -Type String -Value Mouse
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 11 -Type String -Value Region and Language
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 12 -Type String -Value Folder Options
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\RestrictCpl" -ValueName 13 -Type String -Value Credential Manager
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Programs" -ValueName NoProgramsAndFeatures -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" -ValueName DisableRegistryTools -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" -ValueName DisableTaskMgr -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" -ValueName Wallpaper -Type String -Value %windir%\\ProgramFiles (x86)\\Citrix\\App Delivery Setup Tools\\citrix_logo.jpg
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Uninstall" -ValueName NoAddRemovePrograms -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Uninstall" -ValueName NoAddFromCDorFloppy -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Uninstall" -ValueName NoAddFromNetwork -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Uninstall" -ValueName NoChooseProgramsPage -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Uninstall" -ValueName NoRemovePage -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Uninstall" -ValueName NoWindowsSetupPage -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\WindowsUpdate" -ValueName DisableWindowsUpdateAccess -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\WindowsUpdate" -ValueName DisableWindowsUpdateAccessMode -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName Proxy -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName AdvancedTab -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName ConnectionsTab -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName ProgramsTab -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName SecurityTab -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\MMC" -ValueName RestrictToPermittedSnapins -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\Personalization" -ValueName ThemeFile -Type String -Value %windir%\\resources\\Ease of Access Themes\\NewBasic.theme
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\Task Scheduler5.0" -ValueName Task Deletion -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\Task Scheduler5.0" -ValueName Execution -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\Task Scheduler5.0" -ValueName Task Creation -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU" -ValueName NoAUShutdownOption -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU" -ValueName NoAUAsDefaultShutdownOption -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\CurrentVersion\\Internet Settings\\ZoneMapKey" -ValueName $1 -Type String -Value 1
  #output htm of GPO
  get-gporeport $gp_name -reporttype html -path ($home + "\\" + $gp_name + ".html")
  Stop-Transcript
  Clear
  write-host ($GP_NAME + ".htm") exported to $home
  EOH
  not_if {::File.exists?(node['ru']['file'])}
  not_if {reboot_pending?}
end

windows_reboot 30 do
  reason 'A System Restart has been requested. Rebooting now..'
  only_if {reboot_pending?}
end