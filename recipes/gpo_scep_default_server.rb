#
# Cookbook Name:: windows_activedirectory
# Recipe:: gpo_scep_default_server
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
powershell_script "SCEP-Default_Server" do
  code <<-EOH
  $date = Get-Date -DisplayHint Date -Format ddMMMyyy
  $time = get-date -displayhint time -format hh-mm-ss
  # Define Group Policy Name
  $GP_NAME = "SCEP-Default_Server"
  #Begin recording output
  start-transcript -path ($home + "\\" + $GP_NAME + "_Script_" + $date + $time + ".txt")
  import-module grouppolicy
  # Create new group policy object
  New-GPO -name $GP_NAME
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware" -ValueName DisableLocalAdminMerge -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware" -ValueName DisableRoutinelyTakingAction -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware" -ValueName RandomizeScheduleTaskTimes -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName AvgCPULoadFactor -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName CheckForSignaturesBeforeRunningScan -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName DisableHeuristics -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName DisableScanningNetworkFiles -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName DisableArchiveScanning -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName DisableScanningMappedNetworkDrivesForFullScan -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName DisableRemovableDriveScanning -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName DisableRestorePoint -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName DisableCatchupQuickScan -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName DisableCatchupFullScan -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName LocalSettingOverrideAvgCPULoadFactor -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName LocalSettingOverrideScanParameters -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName LocalSettingOverrideScheduleDay -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName LocalSettingOverrideScheduleQuickScanTime -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName LocalSettingOverrideScheduleTime -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName PurgeItemsAfterDelay -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName ScanParameters -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName ScheduleQuickScanTime -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName ScheduleTime -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName ScheduleDay -Type DWORD -Value 8
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Scan" -ValueName ScanOnlyIfIdle -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Quarantine" -ValueName PurgeItemsAfterDelay -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Quarantine" -ValueName LocalSettingOverridePurgeItemsAfterDelay -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName DisableRealtimeMonitoring -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName DisableOnAccessProtection -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName RealTimeScanDirection -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName LocalSettingOverrideDisableRealTimeMonitoring -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName LocalSettingOverrideDisableIntrusionPreventionSystem -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName LocalSettingOverrideDisableOnAccessProtection -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName LocalSettingOverrideDisableIOAVProtection -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName LocalSettingOverrideDisableBehaviorMonitoring -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName LocalSettingOverrideDisableScriptScanning -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName LocalSettingOverrideRealTimeScanDirection -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName DisableScriptScanning -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName DisableIntrusionPreventionSystem -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName DisableIOAVProtection -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Real-Time Protection" -ValueName DisableBehaviorMonitoring -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Threats\\ThreatSeverityDefaultAction" -ValueName 5 -Type String -Value 2
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Threats\\ThreatSeverityDefaultAction" -ValueName 4 -Type String -Value 2
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Threats\\ThreatSeverityDefaultAction" -ValueName 2 -Type String -Value 2
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Threats\\ThreatSeverityDefaultAction" -ValueName 1 -Type String -Value 2
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Signature Updates" -ValueName RealTimeSignatureDelivery -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Signature Updates" -ValueName SignatureUpdateInterval -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Signature Updates" -ValueName SignatureUpdateCatchupInterval -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Signature Updates" -ValueName FallbackOrder -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Signature Updates" -ValueName DefinitionUpdateFileSharesSources -Type String -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Signature Updates" -ValueName ScheduleDay -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Signature Updates" -ValueName ScheduleTime -Type DWORD -Value 1
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %allusersprofile%\\NTUser.pol -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %systemroot%\\system32\\GroupPolicy\\registry.pol -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\Security\\database\\*.chk -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\Security\\database\\*.edb -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\Security\\database\\*.jrs -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\Security\\database\\*.log -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\Security\\database\\*.sdb -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\SoftwareDistribution\\Datastore\\Datastore.edb -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\SoftwareDistribution\\Datastore\\Logs\\edb.chk -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\SoftwareDistribution\\Datastore\\Logs\\edb*.log -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\SoftwareDistribution\\Datastore\\Logs\\Edbres00001.jrs -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\SoftwareDistribution\\Datastore\\Logs\\Edbres00002.jrs -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\SoftwareDistribution\\Datastore\\Logs\\Res1.log -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\SoftwareDistribution\\Datastore\\Logs\\Res2.log -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Paths" -ValueName %windir%\\SoftwareDistribution\\Datastore\\Logs\\tmp.edb -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\SpyNet" -ValueName LocalSettingOverrideSpyNetReporting -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\SpyNet" -ValueName SpyNetReporting -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\UX Configuration" -ValueName Notification_Suppress -Type DWORD -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\UX Configuration" -ValueName CustomDefaultActionToastString -Type String -Value 1
  #output htm of GPO
  get-gporeport $gp_name -reporttype html -path ($home + "\\" + $gp_name + ".html")
  Stop-Transcript
  Clear
  write-host ($GP_NAME + ".htm") exported to $home
  EOH
  not_if {::File.exists?(node['scep']['default'])}
  not_if {reboot_pending?}
end  
