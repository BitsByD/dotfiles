#!/bin/bash

# Need to get zsh set up first so that all subsequent installs push
# configs and settings into zshrc not elsewhere.

# Using asdf for all languages

if [[ $OSTYPE == "darwin"* ]]; then
    echo "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # Temporarily tell homebrew where to put things
    export PATH="/usr/local/bin:$PATH"
    brew update
    brew install curl git
    brew install zsh
else
    sudo apt update
    sudo apt-get install git curl -y
fi

sudo chsh -s $(which zsh) $USER

# Install Oh My Zshell
ZSH="$HOME/.local/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Add a theme
git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
ln -s "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme"
ln -s "$ZSH_CUSTOM/themes/typewritten/async.zsh" "$ZSH_CUSTOM/themes/async"
sed -i 's/^ZSH_THEME.*/ZSH_THEME="typewritten"/' $HOME/.zshrc


# Manage all languages using asdf so let's install it.
asdf="$HOME/.asdf"
if [ -d "$asdf" ]; then rm -Rf $asdf; fi
git clone https://github.com/asdf-vm/asdf.git $asdf --branch v0.9.0


# Add a few omz plugins, including the asdf one
sed -i 's/^plugins.*/plugins=(ssh-agent git asdf pip tmux)/' $HOME/.zshrc
