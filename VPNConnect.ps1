#$vpnName = "Navex Charlotte";
$TokenU = (Get-SecureToken -Name mailname).Token
$TokenP = (Get-SecureToken -Name mail).Token
if ($TokenP) {
  $vpnName = "Charlotte";
  Write-Host "rasdial " $vpnName $TokenU -ForegroundColor Blue
    $vpn = Get-VpnConnection -Name $vpnName;
    if($vpn.ConnectionStatus -eq "Disconnected"){
     rasdial $vpnName "$TokenU" "$TokenP"
    }
}
 else {
    "No token found"
 }