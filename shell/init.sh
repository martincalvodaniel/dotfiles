source "$DOTFILES_PATH/shell/aliases.sh"
source "$DOTFILES_PATH/shell/exports.sh"
source "$DOTFILES_PATH/shell/functions.sh"

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$DOTFILES_PATH/bin"
export PATH="$PATH:$DOTFILES_PATH/scripts"

# Mango
if [ -d "$DOTFILES_PATH/scripts/.no-commit/mango" ]; then
    export PATH="$PATH:$DOTFILES_PATH/scripts/.no-commit/mango"
fi
if [ -f "$DOTFILES_PATH/shell/.no-commit.mango-aliases.sh" ]; then
    source "$DOTFILES_PATH/shell/.no-commit.mango-aliases.sh"
fi
if [ -f "$DOTFILES_PATH/shell/.no-commit.mango-functions.sh" ]; then
    source "$DOTFILES_PATH/shell/.no-commit.mango-functions.sh"
fi
