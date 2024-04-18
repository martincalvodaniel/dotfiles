# Enable aliases to be sudo’ed
alias sudo='sudo '

# JUMPS
alias ~="cd ~"
alias cdw="cd ~/workspace"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ll="exa -la --icons"

alias d2u='dos2unix'

# GIT
alias gaa="git add -A"
alias gb="git branch"
alias gc="git commit"
alias gca="git add --all && git commit --amend --no-edit"
alias gcl="git clone"
alias gd="git diff"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpl="git pull --rebase --autostash"
alias gpsf="git push --force"
alias gs="git status -sb"

# IDEA
alias ij='sh /opt/idea/bin/idea.sh > /opt/idea/log/ij.log 2>&1 &'
alias ijp='sh /opt/idea/bin/idea.sh . > /opt/idea/log/ijp.log 2>&1 &'
alias i.='ijp'
alias c.='code .'
alias o.='open .'

# DOCKER
alias drm='docker_remove'
alias drmi='docker_remove_image'
alias docker-rmi-dangling='docker rmi $(docker images -f "dangling=true" -q)'

# K8S
alias k="kubectl"
alias kctx='f() { [ "$1" ] && kubectl config set-context --current --namespace $1; } ; f'

## logs
alias kl="k logs"
alias klf="kl -f"
## get
alias kg="k get"
alias kgn="kg node"
alias kgns="kg ns"
alias kgp="kg pod"
alias kgd="kg deploy"
alias kgcj="kg cj"
alias kgs="kg svc"
alias kgi="kg ingress"
## describe
alias kd="k describe"
alias kdn="kd node"
alias kdns="kd ns"
alias kdp="kd pod"
alias kdd="kd deploy"
alias kdcj="kd cj"
alias kds="kd svc"
alias kdi="kd ingress"
## edit
alias ke="k edit"
alias ked="ke deploy"
alias kecj="ke cj"
alias kes="ke svc"
alias kei="ke ingress"
## patch
alias kp="k patch"
alias kpd="kp deploy"
alias kpcj="kp cj"

alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

#JAVA
alias j8="sdk use java 8.0.402-tem"
alias j11="sdk use java 11.0.22-tem"
alias j17="sdk use java 17.0.10-tem"
alias j21="sdk use java 21.0.2-tem"

alias reload="source ~/.zshrc"
alias weather="curl -4 wttr.in/Zaragoza\?lang=es"

# WSL specific things
if grep --quiet microsoft /proc/version 2>/dev/null; then
  alias idea="(pkill -f 'java.*idea' || true) && screen -d -m /opt/idea/bin/idea.sh"
  alias wslb="PowerShell.exe 'Start-Process PowerShell -Verb RunAs \"PowerShell -File \$env:USERPROFILE\\wsl2-bridge.ps1\"'"
  alias dcs="sudo /etc/init.d/docker start"
fi
