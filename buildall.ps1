set-location \code\insights

. $PSScriptRoot\VPNConnect

. $PSScriptRoot\buildetl

. $PSScriptRoot\buildapi

. ..\dev-deploy\Launcher\Launcher.ps1
$engines = Launch-DevDeploy -verbose

