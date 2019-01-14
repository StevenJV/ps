set-location \code\insights

$vpnName = "Navex Charlotte";
    $vpn = Get-VpnConnection -Name $vpnName;
    if($vpn.ConnectionStatus -eq "Disconnected"){
    rasdial $vpnName;
    }

. $PSScriptRoot\buildetl

. $PSScriptRoot\buildapi

. ..\dev-deploy\Launcher\Launcher.ps1
$engines = Launch-DevDeploy -verbose

