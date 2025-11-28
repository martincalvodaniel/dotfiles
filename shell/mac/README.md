# macOS Shell Configuration

This directory contains shell configuration files for macOS.

## Shell Configuration Files

The following configuration files have been moved to this location and symlinked from the home directory:

- `.zshrc` → `.dotfiles/shell/mac/.zshrc`
- `.bash_profile` → `.dotfiles/shell/mac/.bash_profile`
- `.zimrc` → `.dotfiles/shell/mac/.zimrc`

### Recreate Symbolic Links

If needed, recreate the symbolic links with:

```bash
ln -s ~/.dotfiles/shell/mac/.zshrc ~/.zshrc
ln -s ~/.dotfiles/shell/mac/.bash_profile ~/.bash_profile
ln -s ~/.dotfiles/shell/mac/.zimrc ~/.zimrc
```

These configuration files are now version-controlled in your dotfiles repository while remaining functional in the home directory through symbolic links.
