#
# Cookbook Name:: windows_activedirectory
# Recipe:: gpo_CtxUPM
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
powershell_script "CtxUPM" do
  code <<-EOH
  # Define Group Policy Name
  $GP_NAME = "CTX_UserProfileManagement"
  #Get date/time information
  $date = Get-Date -DisplayHint Date -Format ddMMMyyy
  $time = get-date -displayhint time -format hh-mm-ss
  #Begin recording output
  start-transcript -path ($home + "\\" + $GP_NAME + "_Script_" + $date + $time + ".txt")
  import-module grouppolicy
  # Create new group policy object
  New-GPO -name $GP_NAME
  # prompt to get path for user store
  # $v0 = read-host "Enter path to user store. EX: \\\\server1\\profiles$\\%Username%"
  # $v1 = read-host "Enter path to store logs. EX: \\\\server\\upmlogs"
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName ServiceActive -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName PathToUserStore -Type String -Value $v0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName ProcessAdmins -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName ProcessCookieFiles -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName DeleteCachedProfilesOnLogoff -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName TemplateProfilePath -Type String -Value C:\\Users\\Default
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName TemplateProfileOverridesLocalProfile -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName TemplateProfileOverridesRoamingProfile -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName PSEnabled -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName PSMidSessionWriteBack -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName LoggingEnabled -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName MaxLogSize -Type DWORD -Value 1048576
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName PathToLogFile -Type String -Value $v1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName LogLevelWarnings -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName LogLevelLogon -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName LogLevelLogoff -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName LogLevelUserName -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName MigrateWindowsProfilesToUserStore -Type DWORD -Value 4
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager" -ValueName LocalProfileConflictHandling -Type DWORD -Value 2
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\ExclusionListRegistry" -ValueName Enabled -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\ExclusionListRegistry\\List" -ValueName Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\TrayNotify -Type String -Value Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\TrayNotify
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncDirList" -ValueName Enabled -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncDirList\\List" -ValueName AppData\\Local\\Microsoft\\Credentials -Type String -Value AppData\\Local\\Microsoft\\Credentials
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncDirList\\List" -ValueName "AppData\\Local\\Citrix\\Citrix offline plug-in" -Type String -Value "AppData\\Local\\Citrix\\Citrix offline plug-in"
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncDirList\\List" -ValueName AppData\\Local\\Microsoft\\Outlook -Type String -Value AppData\\Local\\Microsoft\\Outlook
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncDirList\\List" -ValueName "AppData\\Local\\Microsoft\\Internet Explorer" -Type String -Value "AppData\\Local\\Microsoft\\Internet Explorer"
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir" -ValueName Enabled -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName ("$"+"Recycle.Bin") -Type String -Value ("$"+"Recycle.Bin")
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName AppData\\Local -Type String -Value AppData\\Local
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName AppData\\LocalLow -Type String -Value AppData\\LocalLow
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName AppData\\Roaming\\Citrix\\PNAgent\\AppCache -Type String -Value AppData\\Roaming\\Citrix\\PNAgent\\AppCache
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName "AppData\\Roaming\\Citrix\\PNAgent\\Icon Cache" -Type String -Value "AppData\\Roaming\\Citrix\\PNAgent\\Icon Cache"
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName AppData\\Roaming\\Citrix\\PNAgent\\ResourceCache -Type String -Value AppData\\Roaming\\Citrix\\PNAgent\\ResourceCache
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName AppData\\Roaming\\ICAClient\\Cache -Type String -Value AppData\\Roaming\\ICAClient\\Cache
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName "AppData\\Roaming\\Macromedia\\Flash Player\\#SharedObjects" -Type String -Value "AppData\\Roaming\\Macromedia\\Flash Player\\#SharedObjects"
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName "AppData\\Roaming\\Macromedia\\Flash Player\\macromedia.com\\support\\flashplayer\\sys" -Type String -Value "AppData\\Roaming\\Macromedia\\Flash Player\\macromedia.com\\support\\flashplayer\\sys"
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName "AppData\\Roaming\\Microsoft\\Windows\\Start Menu" -Type String -Value "AppData\\Roaming\\Microsoft\\Windows\\Start Menu"
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName AppData\\Roaming\\Sun\\Java\\Deployment\\cache -Type String -Value AppData\\Roaming\\Sun\\Java\\Deployment\\cache
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName AppData\\Roaming\\Sun\\Java\\Deployment\\log -Type String -Value AppData\\Roaming\\Sun\\Java\\Deployment\\log
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncExclusionListDir\\List" -ValueName AppData\\Roaming\\Sun\\Java\\Deployment\\tmp -Type String -Value AppData\\Roaming\\Sun\\Java\\Deployment\\tmp
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncFileList" -ValueName Enabled -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Citrix\\UserProfileManager\\SyncFileList\\List" -ValueName AppData\\Local\\Microsoft\\Office\\*.officeUI -Type String -Value AppData\\Local\\Microsoft\\Office\\*.officeUI
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\Software\\Policies\\Microsoft\\Windows\\System" -ValueName UserPolicyMode -Type DWORD -Value 2
  #output htm of GPO
  get-gporeport $gp_name -reporttype html -path ($home + "\\" + $gp_name + ".html")
  Stop-Transcript
  Clear
  write-host ($GP_NAME + ".htm") exported to $home
  EOH
  not_if {::File.exists?(node['upm']['file'])}
  not_if {reboot_pending?}
end

windows_reboot 30 do
  reason 'A System Restart has been requested. Rebooting now..'
  only_if {reboot_pending?}
end