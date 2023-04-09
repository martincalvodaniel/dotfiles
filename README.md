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
```
</details>

<details>
  <summary>Git config</summary>

```shell
ln -s .dotfiles/shell/bash/.bash_profile .bash_profile
ln -s .dotfiles/shell/bash/.bashrc .bashrc
ln -s .dotfiles/shell/bash/.profile .profile
ln -s .dotfiles/git/.gitconfig .gitconfig
ln -s .dotfiles/git/.gitignore_global .gitignore_global

source ~/.bashrc
```
</details>