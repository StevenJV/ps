set-location \code\insights

. $PSScriptRoot\VPNConnect

. $PSScriptRoot\buildetl

. $PSScriptRoot\buildapi

. ..\dev-deploy\Launcher\Launcher.ps1
# $engines = Launch-DevDeploy -verbose
Push-Location  UI\insights-ui
npm run build 
Pop-Location


