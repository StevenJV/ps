PATH="/usr/local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export ARTIFACTORY_USER=steven.vore@coxautoinc.com
export ARTIFACTORY_API_KEY=[redacted]
export ASPNETCORE_ENVIRONMENT=docker

export GECKO_DRIVER=~/Library/GeckoDriver
export NUGET_PKGS=/Users/$USER/.nuget/packages
export PATH=${PATH}:$GECKO_DRIVER

export ZSH=$HOME/.oh-my-zsh
#export ZSH_THEME=jnrowe
export ZSH_THEME=af-magic
#also changed af-magic.zsh-theme line 23 from ${FG[032]} to ${FG[011]} color from `spectrum_ls`


export SERVICE=listings_service
export JMETER_TEST_ENV=dev
export PLAN_NAME=ListingsService_V2_Combo_Stress_Test.jmx
export JMETER_PROJECT_PATH="/Users/steven.vore/code/CAL.CD.Listings.API.LoadTesting"
export SLAVES_COUNT=1
export THREADS_COUNT=1000
export RAMP_UP_PERIOD=600
export TEST_DURATION=3000
export TIMER_DELAY_DEVIATION=500
export TIMER_DELAY_CONSTANT=1000
export RPM_CREATE_LISTING=2120
export RPM_GET_LISTING=5700
export RPM_UPDATE_LISTING=4780
export RPM_GET_UPDATE_LISTING=3080
export RPM_DELETE_LISTING=1700

alias -g jmeter="/Applications/apache-jmeter-5.2.1-2/bin/jmeter.sh"
alias -g lsl="ls -l "
alias -g gitlog="git log --pretty=format:'%C(yellow) %ad %C(white)%h%Cred%d %Creset%s%Cred [%cn]' --decorate --date=format:'%Y-%m-%d %H:%M'"
alias -g slog="git log --pretty=format:'%C(yellow) %ad %C(white)%h%Cred%d %Creset%s%Cred [%cn]' --decorate --date=format:'%Y-%m-%d %H:%M'"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
source $ZSH/oh-my-zsh.sh