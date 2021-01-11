. $PSScriptRoot\stopinsights.ps1

remove-item c:\logs\*.* -force  -exclude HostService*.*

. $PSScriptRoot\startinsights.ps1