# dotfiles

<details>
  <summary>Common dependencies</summary>

```shell
sudo apt update

sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    exa \
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

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
```

</details>

<details>
  <summary>Git config</summary>

```shell
# git
ln -s .dotfiles/git/.gitignore_global .gitignore_global
ln -s .dotfiles/git/.gitconfig .gitconfig

# bash
ln -s .dotfiles/shell/bash/.bash_logout .bash_logout
ln -s .dotfiles/shell/bash/.bash_aliases .bash_aliases
ln -s .dotfiles/shell/bash/.bash_profile .bash_profile
ln -s .dotfiles/shell/bash/.bashrc .bashrc
ln -s .dotfiles/shell/bash/.profile .profile

# zsh
## oh-my-zsh with zim
ln -s .dotfiles/shell/zsh/.zimrc .zimrc
ln -s .dotfiles/shell/zsh/.zshrc

## oh-my-zsh with antibody
ln -s .dotfiles/shell/zsh/antibody/.zshenv .zshenv
ln -s .dotfiles/shell/zsh/antibody/.zshrc .zshrc
ln -s .dotfiles/shell/zsh/antibody/.p10k.zsh .p10k.zsh
ln -s .dotfiles/shell/zsh/antibody/.zsh_plugins.zsh .zsh_plugins.zsh
```

</details>
