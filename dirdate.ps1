Param([string]$path, [string]$filter, [switch]$help)

Function Sort-Files ([string]$path,[string]$filter)
{
 Get-ChildItem -Path $path -Filter $filter | 
 Sort-Object -Property CreationTime
} #end Sort-Files

Function Get-HelpText
{
 $helpText = @"
DESCRIPTION:
  Sorts files by creation date. Accepts parameter for path and file type.
EXAMPLE:
  SortFilesInFolderByCreationDate.ps1 -path c:\fso -filter "*.txt"
  SortFilesInFolderByCreationDate.ps1 -p c:\fso -f *.txt
  SortFilesInFolderByCreationDate.ps1 c:\fso *.txt
"@
 $helpText
} #end Get-HelpText
# *** Entry point to Script ***

if($help) { Get-HelpText ; exit }
Sort-Files -path $path -filter $filter | 
Format-Table -property name, creationtime -AutoSize
