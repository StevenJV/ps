PATH="/usr/local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="$HOME/bin:$PATH"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export ARTIFACTORY_USER=[redacted]]
-- there were keys here for Artifactory, Rally, and a token for GitHub
export ASPNETCORE_ENVIRONMENT=docker
#export GECKO_DRIVER=~/Library/GeckoDriver
export GECKO_DRIVER=/opt/homebrew/bin/geckodriver
export NUGET_PKGS=/Users/$USER/.nuget/packages
export PATH=${PATH}:$GECKO_DRIVER

export ZSH=$HOME/.oh-my-zsh
#export ZSH_THEME=jnrowe
#export ZSH_THEME=af-magic
#also changed af-magic.zsh-theme line 23 from ${FG[032]} to ${FG[011]} color from `spectrum_ls`
export ZSH_THEME=crunch
source $ZSH/oh-my-zsh.sh

export SERVICE=listings_api_service
export JMETER_TEST_ENV=stage
export PLAN_NAME=ListingsAPIService_Combination_stress_test
export JMETER_PROJECT_PATH="/Users/steven.vore/code/CAL.CD.Listings.API.LoadTesting"
export SLAVES_COUNT=1
export THREADS_COUNT=100
export RAMP_UP_PERIOD=1
export TEST_DURATION=60
export TIMER_DELAY_DEVIATION=50
export TIMER_DELAY_CONSTANT=10
export RPM_CREATE_LISTING=50
export RPM_GET_LISTING=50
export RPM_UPDATE_LISTING=50
export RPM_GET_UPDATE_LISTING=50
export RPM_DELETE_LISTING=50

# for CAL.CD.TestAutomation
# Options: local, dev, stage
# Primary environment variable
export IT_ENV=stage
# Legacy compatibility
export IT_ENVIRONMENT=stage

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"


alias -g jmeter="/Applications/apache-jmeter-5.2.1-2/bin/jmeter.sh"
alias -g lsl="ls -l "
alias -g gitlog="git log --pretty=format:'%C(yellow) %ad %C(white)%h%Cred%d %Creset%s%Cred [%cn]' --decorate --date=format:'%Y-%m-%d %H:%M'"
alias -g slog="git log --pretty=format:'%C(yellow) %ad %C(white)%h%Cred%d %Creset%s%Cred [%cn]' --decorate --date=format:'%Y-%m-%d %H:%M'"
alias -g diff="code --wait --diff "
alias -g cleanbranchesfrommaster="git switch master; git branch --merged | grep -Ev \"(^\*|^\+|master|main|dev)\" | xargs --no-run-if-empty git branch -d"
alias -g cleanbranchesfrommain="git switch main; git branch --merged | grep -Ev \"(^\*|^\+|master|main|dev)\" | xargs --no-run-if-empty git branch -d"
alias -g dockernuke="docker system prune -a"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
// added by uv (Python package manager)?
export PATH="$HOME/.dotnet:$PATH"
