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
default['ac']['file'] = "c:/users/ctxadmin/CTX_AppConfig.html"
default['dp']['file'] = "c:/users/ctxadmin/CTX_Default_Policy.html"
default['pu']['file'] = "c:/users/ctxadmin/Ctx_PersonalizedUser.html"
default['rc']['file'] = "c:/users/ctxadmin/CTX_RestrictedComputer.html"
default['ru']['file'] = "c:/users/ctxadmin/CTX_RestrictedUser.html"
default['sm']['file'] = "c:/users/ctxadmin/CTX_StartMenuTaskBar.html"
default['upm']['file'] = "c:/users/ctxadmin/CTX_UserProfileManagement.html"

default['scep']['default'] = "c:/users/ctxadmin/SCEP-Default_Server.html"
default['scep']['dhcp'] = "c:/users/ctxadmin/SCEP-DHCP_Server.html"
default['scep']['dns'] = "c:/users/ctxadmin/SCEP-DNS_Server.html"
default['scep']['dc'] = "c:/users/ctxadmin/SCEP-Domain_Controller.html"
default['scep']['fs'] = "c:/users/ctxadmin/SCEP-File_Server.html"
default['scep']['iis'] = "c:/users/ctxadmin/SCEP-IIS_Server.html"
default['scep']['sql'] = "c:/users/ctxadmin/SCEP-SQL_2008.html"
default['scep']['ts'] = "c:/users/ctxadmin/SCEP-Terminal_Server.html"