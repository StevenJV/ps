Param(
  [string]$filename,
  [string]$target
)
ls -r $filename | sls $target
