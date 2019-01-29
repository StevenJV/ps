Import-Module SecureTokens 
$vpnName = "Charlotte";  # change this to the name of your vpn connection 
$TokenU = (Get-SecureToken -Name vpnuser).Token
$TokenP = (Get-SecureToken -Name vpnpwd).Token
if ($TokenP -and $TokenU) {
  Write-Host "using rasdial to connect: " $vpnName $TokenU -ForegroundColor Blue
    $vpn = Get-VpnConnection -Name $vpnName;
    if($vpn.ConnectionStatus -eq "Disconnected"){
     rasdial $vpnName "$TokenU" "$TokenP"
    }
    else {
      write-host "VPN already connected."
    }
}
 else {
  $message = "
No token found. Use Add-SecureToken twice for tokens 'vpnuser' and 'vpnpwd'
 download the https://github.com/brsh/SecureTokens module,
 then use this to set up your environment:

 Import-Module SecureTokens
 Add-SecureToken -name vpnuser -token YOUR_USERNAME
 Add-SecureToken -name vpnpwd -token YOUR PASSWORD
";
  Write-Host $message 
}