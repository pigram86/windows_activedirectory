#
# Cookbook Name:: windows_activedirectory
# Recipe:: gpo_scep_sql_server
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
  $GP_NAME = "SCEP-SQL_2008"
  #Begin recording output
  start-transcript -path ($home + "\\" + $GP_NAME + "_Script_" + $date + $time + ".txt")
  import-module grouppolicy
  # Create new group policy object
  New-GPO -name $GP_NAME
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Processes" -ValueName "%ProgramFiles%\\Microsoft SQL Server\\MSSQL10.MSSQLSERVER\\MSSQL\\Binn\\SQLServr.exe" -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Processes" -ValueName "%ProgramFiles%\\Microsoft SQL Server\\MSRS10.MSSQLSERVER\\Reporting Services\\ReportServer\\Bin\\ReportingServicesService.exe" -Type String -Value 0
  Set-GPRegistryValue -Name $GP_NAME -key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Microsoft Antimalware\\Exclusions\\Processes" -ValueName "%ProgramFiles%\\Microsoft SQL Server\\MSAS10.MSSQLSERVER\\OLAP\\Bin\\MSMDSrv.exe" -Type String -Value 0
  #output htm of GPO
  get-gporeport $gp_name -reporttype html -path ($home + "\\" + $gp_name + ".html")
  Stop-Transcript
  Clear
  write-host ($GP_NAME + ".htm") exported to $home
  EOH
  not_if {::File.exists?(node['scep']['sql'])}
  not_if {reboot_pending?}
end
