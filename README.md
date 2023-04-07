# dotfiles

<details>
  <summary>Common dependencies</summary>

```shell
sudo apt update

sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    fzf \
    git \
    gnupg-agent \
    make \
    software-properties-common \
    tig \
    tree \
    vim \
    wget \
    zip unzip \
    zsh
```
</details>

<details>
  <summary>Git config</summary>

```shell
# Set username and email for next commands
email="martincalvodaniel@gmail.com"
username="dmartinc"

# Configure Git
echo "[GIT] Setting git config paramaters"
git config --global user.email "${email}"
git config --global user.name "${username}"
git config --global core.excludesfile ~/.gitignore

# Configure git alias
echo "[GIT] Alias setup"
git config --global alias.s "status -s"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.mergec "merge --no-ff --no-commit"
git config --global alias.gclean "clean -d -f -f"

# Generate and show a new SSH key
ssh-keygen -t rsa -b 4096 -C "${email}"
cat ~/.ssh/id_rsa.pub
```
</details>