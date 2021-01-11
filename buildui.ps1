$T = Get-Date -DisplayHint time
Write-Host "** $T Building UI  *****************************************" -foregroundcolor blue -BackgroundColor White
Push-Location  UI\insights-ui
npm run rebuild 
Pop-Location