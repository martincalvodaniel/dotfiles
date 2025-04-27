# dotfiles

<details>
  <summary>Common dependencies</summary>

  ```shell
  sudo apt update

  sudo apt install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      eza \
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
  <summary>Ssh config</summary>

```shell
# ssh
## id_rsa
ssh-keygen -t rsa -C "martincalvodaniel@gmail.com"
cat .ssh/id_rsa.pub
## id_rsa_mango
ssh-keygen -t rsa -C "daniel.martin.mango@gmail.com"
cat .ssh/id_rsa_mango.pub

vi ~/.ssh.config
```

```
Host me.github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa

Host work.github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_mango
```

</details>

<details>
  <summary>Git config</summary>

```shell
# git
git clone git@github.com:martincalvodaniel/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/git/.gitignore_global .gitignore_global
ln -s ~/.dotfiles/git/.gitconfig .gitconfig
```

</details>

<details>
  <summary>Shell config</summary>

```shell
# bash

rm -rf ~/.bash_logout || true
rm -rf ~/.bash_aliases || true
rm -rf ~/.bash_profile || true
rm -rf ~/.bashrc || true
rm -rf ~/.profile || true

rm -rf ~/.zimrc || true
rm -rf ~/.zshenv || true
rm -rf ~/.zshrc || true
rm -rf ~/.p10k.zsh || true
rm -rf ~/.zsh_plugins.zsh || true

ln -s ~/.dotfiles/shell/bash/.bash_logout .bash_logout
ln -s ~/.dotfiles/shell/bash/.bash_aliases .bash_aliases
ln -s ~/.dotfiles/shell/bash/.bash_profile .bash_profile
ln -s ~/.dotfiles/shell/bash/.bashrc .bashrc
ln -s ~/.dotfiles/shell/bash/.profile .profile

# zsh
## oh-my-zsh with zim
ln -s ~/.dotfiles/shell/zsh/.zimrc .zimrc
ln -s ~/.dotfiles/shell/zsh/.zshrc

## oh-my-zsh with antibody
ln -s ~/.dotfiles/shell/zsh/antibody/.zshenv .zshenv
ln -s ~/.dotfiles/shell/zsh/antibody/.zshrc .zshrc
ln -s ~/.dotfiles/shell/zsh/antibody/.p10k.zsh .p10k.zsh
ln -s ~/.dotfiles/shell/zsh/antibody/.zsh_plugins.zsh .zsh_plugins.zsh

echo "[ZSH] Installing antibody..."
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

echo "[ZSH] Antibody installing plugins ..."
antibody bundle < ~/.dotfiles/shell/zsh/antibody/zsh_plugins > ~/.zsh_plugins.zsh

# Create .screen folder used by .zshrc
mkdir ~/.screen && chmod 700 ~/.screen

# Change default shell to zsh
chsh -s $(which zsh)
```



* https://www.nerdfonts.com/font-downloads
  * JetBrainsMono Nerd Font
    * JetBrainsMonoNerdFont-Regular

</details>
