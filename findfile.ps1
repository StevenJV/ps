Param(
  [string]$filename
)
Get-Childitem -Path . -Include $filename -File -Recurse -ErrorAction SilentlyContinue