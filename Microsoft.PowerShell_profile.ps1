import-module psreadline
set-Alias which get-command
Set-Alias gitc GitCommit
set-alias log GitLog
set-alias slog GitShortLog
set-alias cleanjson GitCheckoutJson
set-alias branches c:\code\ps\branches.ps1
set-Alias remotebranches c:\code\ps\remotebranches.ps1
set-Alias launch c:\code\ps\launch.ps1
set-Alias dirdate c:\code\ps\dirdate.ps1
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
function GitCheckoutJson {
  git checkout client/public/assets/fonts/fontello/config.json
}

$env:Term="xterm"
# Chocolatey profile
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }
if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}
# Load posh-git  profile
. 'C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.1\posh-git.profile.ps1'
# . 'C:\Users\steve\OneDrive\Documents\WindowsPowerShell\ConemuPrompt.ps1'
Rename-Item Function:\Prompt PoshGitPrompt -Force
function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){++$global:poshScope; New-Item function:\script:Write-host -value "param([object] `$object, `$backgroundColor, `$foregroundColor, [switch] `$nonewline) " -Force | Out-Null;$private:p = PrePoshGitPrompt; if(--$global:poshScope -eq 0) {Remove-Item function:\Write-Host -Force}}PoshGitPrompt}
