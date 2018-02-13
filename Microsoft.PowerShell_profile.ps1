import-module psreadline
set-Alias which get-command
Set-Alias gitc GitCommit
set-alias log GitLog
set-alias shortlog GitShortLog
set-alias cleanjson GitCheckoutJson
set-alias branches c:\code\ps\branches.ps1
set-Alias remotebranches c:\code\ps\remotebranches.ps1
set-Alias launch c:\code\ps\launch.ps1
set-Alias dirdate c:\code\ps\dirdate.ps1
function GitShortLog {
  git log --pretty=format:"%h %ad %cn: %s" --date=short
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
# Powershell to do a remote session on board boxes and fishes easily from @Ricardo
# function SetMyCred {
#   if (!$global:cred) {
#     $global:cred = Get-Credential dev\svore
#   }
# }
# function e($server) {
#   SetMyCred
#   $boardBoxes = @("cobalt", "carbon", "iron", "platinum")
#   $fish = @("ray", "silverfish", "monkfish", "gar", "carp", "barracuda", "marlin", "goby", "grouper")
#   if ($boardBoxes -contains $server) {
#     $server = "$server-board"
#   }
#   if ($fish -contains $server) {
#     $server = "$server-qa"
#   }
#   Enter-PSSession "$server.dev.labs" -Credential $global:cred
# }
# # Powershell convenience for suite launch from @Ricardo
# function l {
#   Push-Location c:\grc\;rake launch:basic;Pop-Location
# }
# function b {
#   Push-Location c:\grc\;rake build;Pop-Location
# }
# function bn {
#   Push-Location c:\grc\;rake build:dot_net;Pop-Location
# }
# function bt {
#   Push-Location c:\grc\;rake build:project project=\platform\TaskRunner\TaskRunner.csproj;Pop-Location
# }
# function c {
#   Push-Location c:\grc\;rake clean;Pop-Location
# }
# # Powershell for easy push to QA from @Ricardo
# function qa() {
#     param($server, [Switch] $force)
#     if ($server -Ne "silverfish") {
#         $server = "qa_$server"
#     }
#     if ($force) {
#         $extraCommands = "-f"
#     }
#     Write-Host "git push origin HEAD:$server $extraCommands"
#     & git push origin HEAD:$server $extraCommands
# }

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
