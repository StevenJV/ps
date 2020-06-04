import-module psreadline
set-Alias which get-command
Set-Alias gitc GitCommit
set-alias log GitLog
set-alias slog GitShortLog
set-alias branches c:\code\ps\branches.ps1
set-Alias remotebranches c:\code\ps\remotebranches.ps1
set-Alias dirdate c:\code\ps\dirdate.ps1
Set-Alias grep c:\code\ps\Grep.ps1
set-alias findfile c:\code\ps\findfile.ps1
. C:\code\dev-deploy\Launcher\Launcher.ps1
function GitShortLog {
  git log --pretty=format:'%C(yellow) %ad %C(blue)%h%Cred%d %Creset%s%Cred [%cn]' --decorate --date=format:'%Y-%m-%d %H:%M'
}
function GitLog {
  git log --name-only
}
function GitCommit {
 git commit
}
function aws-login{
  navex aws login
  $complete = Read-Host -Prompt 'Signed in? (Y/N)'
  if ($complete -eq 'Y' -OR $complete -eq 'y'){
    # this is how local-dev Insights reads the credentials for sending notifications
      Copy-Item C:\Users\steve\.aws\credentials C:\aws
      Write-Host 'Ready to go'
  }
  else{
      Write-Host 'Might want to answer Y, credentials not copied'
  }
}

$env:Term="xterm"

Import-Module posh-git
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.AfterText += "`n"
Import-Module oh-my-posh
# Set-Theme Darkblood

# Chocolatey profile
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }
#if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}
# Load posh-git  profile
#. 'C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.1\posh-git.profile.ps1'
#. 'C:\Users\steve\OneDrive\Documents\WindowsPowerShell\ConemuPrompt.ps1'
#Rename-Item Function:\Prompt PoshGitPrompt -Force
#function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){++$global:poshScope; New-Item function:\script:Write-host -value "param([object] `$object, `$backgroundColor, `$foregroundColor, [switch] `$nonewline) " -Force | Out-Null;$private:p = PrePoshGitPrompt; if(--$global:poshScope -eq 0) {Remove-Item function:\Write-Host -Force}}PoshGitPrompt}
