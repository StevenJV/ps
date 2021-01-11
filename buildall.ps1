set-location \code\insights

#. $PSScriptRoot\VPNConnect
$T = Get-Date -DisplayHint time
Write-Host "** $T Building ETL *****************************************" -foregroundcolor blue -BackgroundColor White
. $PSScriptRoot\buildetl

$T = Get-Date -DisplayHint time
Write-Host "** $T Building API *****************************************" -foregroundcolor blue -BackgroundColor White
. $PSScriptRoot\buildapi

. ..\dev-deploy\Launcher\Launcher.ps1
# $engines = Launch-DevDeploy -verbose

. $PSScriptRoot\buildui.ps1

$T = Get-Date -DisplayHint time
Write-Host "** $T " -foregroundcolor blue -BackgroundColor White

