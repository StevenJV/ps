$Env:REPODIR = "~\source\repos\"
set-Alias which get-command
Set-Alias gitc GitCommit
set-alias log GitLog
set-alias slog GitShortLog
set-alias branches ~\source\repos\ps\branches.ps1
set-Alias remotebranches ~\source\repos\ps\remotebranches.ps1
set-Alias dirdate ~\source\repos\ps\dirdate.ps1
Set-Alias grep ~\source\repos\ps\Grep.ps1
set-alias findfile ~\source\repos\ps\findfile.ps1
#Set-Alias Python ~\AppData\Local\Microsoft\WindowsApps\python3.exe

function repos {
  Push-Location  ~\source\repos\
}
function stat {
  git status
}
function GitShortLog {
  git log --pretty=format:'%C(yellow) %ad %C(blue)%h%Cred%d %Creset%s%Cred [%cn]' --decorate --date=format:'%Y-%m-%d %H:%M'
}
function GitLog {
  git log --name-only
}
function GitCommit {
  git commit
}
#import-module psreadline

# Import-Module posh-git
# Import-Module oh-my-posh
# Get-PoshThemes
Set-PoshPrompt star

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }
