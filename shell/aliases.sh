#!/bin/sh

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Jumps
alias ~="cd ~"
alias cdw="cd ~/workspace"
alias dots="cdw && cd martincalvodaniel/dotfiles2k23"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ll="exa -l --icons"
alias la="exa -la --icons"

alias d2u='dos2unix'

# GIT
alias gaa="git add -A"
alias gb="git branch"
alias gc="git commit"
alias gca="git add --all && git commit --amend --no-edit"
alias gcl="git clone"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpl="git pull --rebase --autostash"
alias gpsf="git push --force"
alias gs="git status -sb"

# IDEA
alias ij='sh /opt/idea/bin/idea.sh > /opt/idea/log/ij.log 2>&1 &'
alias ijp='sh /opt/idea/bin/idea.sh . > /opt/idea/log/ijp.log 2>&1 &'

# DOCKER
alias drm='_docker_remove'
alias drmi='_docker_remove_image'

# K8S
alias k="kubectl"
alias kc='echo $KUBECONFIG'
## logs
alias kl="k logs"
alias klf="k logs -f"
## get
alias kgp="k get pod"
alias kgd="k get deploy"
alias kgcj="k get cj"
alias kgs="k get svc"
alias kgi="k get ingress"
## describe
alias kdp="k describe pod"
alias kdd="k describe deploy"
alias kdcj="k describe cj"
alias kds="k describe svc"
alias kdi="k describe ingress"
## edit
alias kep="k edit pod"
alias ked="k edit deploy"
alias kecj="k edit cj"
alias kes="k edit svc"
alias kei="k edit ingress"

#AWS
alias k8s-dev="aws eks update-kubeconfig --name dev"
alias k8s-pre="aws eks update-kubeconfig --name pre"
alias k8s-pro="aws eks update-kubeconfig --name pro"
alias k8s-pro-k8s-tools="aws eks update-kubeconfig --name pro-k8s-tools"

alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

#JAVA
alias j8="sdk use java 8.0.362-tem"
alias j11="sdk use java 11.0.18-tem"
alias j17="sdk use java 17.0.6-tem"

alias hi="echo 'Hello there!'"
alias reload="source ~/.zshrc"

# WSL specific things
if grep --quiet microsoft /proc/version 2>/dev/null; then
  alias idea="(pkill -f 'java.*idea' || true) && screen -d -m /opt/idea/bin/idea.sh"
  alias wslb="PowerShell.exe 'Start-Process PowerShell -Verb RunAs \"PowerShell -File \$env:USERPROFILE\\wsl2-bridge.ps1\"'"
  alias dcs="sudo /etc/init.d/docker start"
fi
