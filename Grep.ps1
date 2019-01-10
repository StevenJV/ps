Param(
  [string]$filename,
  [string]$target
)
ls -r $filename -exclude *.exe, *.dll, *.nupkg, *.dtsx, *.pdb   | sls $target
