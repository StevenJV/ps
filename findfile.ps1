Param(
  [string]$filename
)
Get-Childitem -Path C:\ -Include $filename -File -Recurse -ErrorAction SilentlyContinue