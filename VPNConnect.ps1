Import-Module SecureTokens 
# from https://github.com/brsh/SecureTokens 
# download this, import-module it, then use Add-SecureToken twice for tokens `vpnuser` and `vpnpwd`
$TokenU = (Get-SecureToken -Name vpnuser).Token
$TokenP = (Get-SecureToken -Name vpnpwd).Token
if ($TokenP) {
  $vpnName = "Charlotte";
  Write-Host "rasdial " $vpnName $TokenU -ForegroundColor Blue
    $vpn = Get-VpnConnection -Name $vpnName;
    if($vpn.ConnectionStatus -eq "Disconnected"){
     rasdial $vpnName "$TokenU" "$TokenP"
    }
}
 else {
    "No token found. Use Add-SecureToken twice for tokens 'vpnuser' and 'vpnpwd'"
}