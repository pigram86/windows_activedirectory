#
# Cookbook Name:: windows_activedirectory
# Recipe:: gpo_CtxAppConfig
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

# Created 05-2014 by: Ron Oberjohann
# For more information on the CMDlets used see http://technet.microsoft.com/en-us/library/ee461034.aspx & http://technet.microsoft.com/en-us/library/ee461027.aspx
# Special thanks to Todd Pigram @ http://www.toddpigram.com for the base GPO's to collect recommended settings
# Group Policy Cmdlet Prerequisites
# To use the Windows PowerShell cmdlets for Group Policy, you must be running one of the following: 
# Windows Server 2008 R2 on a domain controller
# --or--
# Windows Server 2008 R2 on a member server that has the GPMC installed
# --or--
# Windows® 7 with Remote Server Administration Tools (RSAT) installed. (RSAT includes the GPMC and the Group Policy cmdlets)

# Always test scripts in a non production affecting method!
# Use at your own risk! The author is NOT responsible for any damages.

# This script does not link to any AD object by default.
# For more information about linking the GPO see http://technet.microsoft.com/en-us/library/ee461061.aspx

#An Example of the command used
#Set-GPRegistryValue -Name "TestGPO" -key "HKCU\\Software\\Policies\\Microsoft\\ExampleKey" -ValueName "ValueOne", "ValueTwo", "ValueThree" 
#Cannot string DWORD VALUES

powershell_script "CtxAppConfig" do
  code <<-EOH
  # Define Group Policy Name
  $GP_NAME = "CTX_AppConfig"
  #Get date/time information
  $date = Get-Date -DisplayHint Date -Format ddMMMyyy
  $time = get-date -displayhint time -format hh-mm-ss
  #Begin recording output
  start-transcript -path ($home + "\\" + $GP_NAME + "_Script_" + $date + $time + ".txt")
  import-module grouppolicy
  # Create new group policy object
  New-GPO -name $GP_NAME
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Ext" -ValueName DisableAddonLoadTimePerformanceNotifications -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Ext" -ValueName IgnoreFrameApprovalCheck -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Communicator" -ValueName FirstRunLaunchMode -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName Proxy -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName ResetWebSettings -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName Check_If_Default -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName "FormSuggest Passwords" -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel" -ValueName HomePage -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Main" -ValueName DisableFirstRunCustomize -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Main" -ValueName "FormSuggest Passwords" -Type String -Value "no"
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Main" -ValueName "FormSuggest PW Ask" -Type String -Value "no"
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Main" -ValueName "Start Page" -Type String -Value "http://www.mcpc.com"
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\PhishingFilter" -ValueName Enabled -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Privacy" -ValueName EnableInPrivateBrowsing -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Recovery" -ValueName AutoRecover -Type DWORD -Value 2
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Restrictions" -ValueName NoCrashDetection -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Restrictions" -ValueName NoHelpItemSendFeedback -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Restrictions" -ValueName NoHelpItemNetscapeHelp -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Restrictions" -ValueName NoHelpItemTipOfTheDay -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\Restrictions" -ValueName NoHelpItemTutorial -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Internet Explorer\\SQM" -ValueName DisableCustomerImprovementProgram -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\access\\security" -ValueName EnableDEP -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\access\\settings" -ValueName "Size of MRU File List" -Type DWORD -Value 4
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\access\\settings" -ValueName ClearCacheOnClose -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common" -ValueName QMEnable -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common" -ValueName UpdateReliabilityData -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\alerts" -ValueName NoAlertReporting -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\fileio" -ValueName DisableLongTermCaching -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\general" -ValueName ShownFirstRunOptin -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\internet" -ValueName DisableDownloadCenterAccess -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\internet" -ValueName DisableCustomerSubmittedDownload -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\internet" -ValueName DisableCustomerSubmittedUpload -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\officeliveworkspace" -ValueName TurnOffOfficeLiveWorkspaceIntegration -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\services\\fax" -ValueName NoFax -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\common\\shipasserts" -ValueName DisableShipAsserts -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\excel\\security" -ValueName EnableDEP -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\infopath\\designer file mru" -ValueName "Max Display" -Type DWORD -Value 4
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\infopath\\filler file mru" -ValueName "Max Display" -Type DWORD -Value 4
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\infopath\\security" -ValueName EnableDEP -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\onenote\\security" -ValueName EnableDEP -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook" -ValueName DisablePst -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\cached mode" -ValueName **del.CachedExchangeMode -Type String -Value ""
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\cached mode" -ValueName Enable -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\options" -ValueName DisableHTTP -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\options" -ValueName DisableExchange -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\options" -ValueName DisablePOP3 -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\options" -ValueName DisableIMAP -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\options" -ValueName DisableOtherTypes -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\options\\mail" -ValueName "Send Mail Immediately" -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\options\\pubcal" -ValueName DisableOfficeOnline -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\ost" -ValueName NoOST -Type DWORD -Value 2
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName DisableManualArchive -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName DoAging -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName EveryDays -Type DWORD -Value 14
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName PromptForAging -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName DeleteExpired -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName ArchiveOld -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName ArchiveMount -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName ArchivePeriod -Type DWORD -Value 6
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName ArchiveGranularity -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\preferences" -ValueName ArchiveDelete -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\pst" -ValueName PSTDisableGrow -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\search" -ValueName DisableDownloadSearchPrompt -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\outlook\\security" -ValueName EnableDEP -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\powerpoint\\security" -ValueName DisablePackageForCD -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\powerpoint\\security" -ValueName EnableDEP -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\publisher\\security" -ValueName EnableDEP -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\word\\file mru" -ValueName "Max Display" -Type DWORD -Value 4
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\14.0\\word\\security" -ValueName EnableDEP -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\office\\groove" -ValueName ProhibitGrooveWorkspaces -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" -ValueName ListBox_Support_ZoneMapKey -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Cache" -ValueName Persistent -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Lockdown_Zones\\1" -ValueName 1609 -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ZoneMapKey" -ValueName http://*.anyplacecloud.com -Type String -Value "2"
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ZoneMapKey" -ValueName https://*.anyplacecloud.com -Type String -Value "2"
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\3" -ValueName 1208 -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\3" -ValueName 2500 -Type DWORD -Value 3
  Set-GPRegistryValue -Name $GP_NAME -key "HKCU\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\4" -ValueName 2500 -Type DWORD -Value 0
  #output htm of GPO
  get-gporeport $gp_name -reporttype html -path ($home + "\\" + $gp_name + ".html")
  Stop-Transcript
  Clear
  write-host ($GP_NAME + ".htm") exported to $home
  EOH
  not_if {::File.exists?(node['ac']['file'])}
  not_if {reboot_pending?}
end

windows_reboot 30 do
  reason 'A System Restart has been requested. Rebooting now..'
  only_if {reboot_pending?}
end
