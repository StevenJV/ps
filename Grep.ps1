Param(
  [string]$target,
  [string]$filename
)
ls -r $filename -exclude *.exe, *.dll, *.nupkg, *.dtsx, *.pdb   | sls $target
