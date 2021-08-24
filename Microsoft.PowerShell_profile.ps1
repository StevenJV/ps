set-Alias which get-command
Set-Alias gitc GitCommit
set-alias log GitLog
set-alias slog GitShortLog
set-alias branches ~\source\repos\ps\branches.ps1
set-Alias remotebranches ~\source\repos\ps\remotebranches.ps1
set-Alias dirdate ~\source\repos\ps\dirdate.ps1
Set-Alias grep ~\source\repos\ps\Grep.ps1
set-alias findfile ~\source\repos\ps\findfile.ps1
. \users\steve\source\repos\dev-deploy\Launcher\Launcher.ps1

function repos {
  cd ~\source\repos\
}


function insights {
  cd ~\source\repos\insights
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
function aws-login{
  navex aws login
  $complete = Read-Host -Prompt 'Signed in? (Y/N)'
  if ($complete -eq 'Y' -OR $complete -eq 'y'){
    # this is how local-dev Insights reads the credentials for sending notifications
      Copy-Item \Users\steve\.aws\credentials \aws
      Write-Host 'Ready to go'
  }
  else{
      Write-Host 'Might want to answer Y, credentials not copied'
  }
}

#import-module psreadline

Import-Module posh-git 
#$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
#$GitPromptSettings.AfterText += "`n"

Import-Module oh-my-posh 
#Set-PoshPrompt Powerlevel10k_Lean
Set-PoshPrompt -Theme ~/.mytheme.omp.json
# Paradox, Fish, Agnoster, Darkblood 

#Import-Module -Name Terminal-Icons

#start-service 'OpenSSH Authentication Agent'
#Start-SshAgent -Quiet

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
