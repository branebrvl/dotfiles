#!/bin/bash

export UNLINK=true

function symlinkifne {
    echo "WORKING ON: $1"
    
    # does it exist
    if [[ -a $1 ]]; then
      echo "  WARNING: $1 already exists."
      
      # If Unlink is requested
      if [ "$UNLINK" = "true" ]; then
          unlink $1
          echo "  Unlinking $1"
          
          # create the link
          export DOTLESS=`echo $1 | sed s/.//`
          echo "  Symlinking $DOTFILESDIRRELATIVETOHOME/$DOTLESS to $1"
          ln -s $DOTFILESDIRRELATIVETOHOME/$DOTLESS $1
      else
        echo "  SKIPPING $1."  
      fi
    # does not exist
    else
      # create the link
      export DOTLESS=`echo $1 | sed s/.//`
      echo "  Symlinking $DOTFILESDIRRELATIVETOHOME/$DOTLESS to $1"
      ln -s $DOTFILESDIRRELATIVETOHOME/$DOTLESS $1
    fi
}


echo "This script must be run from the dotfiles directory"
echo "Setting up..."

#export DOTFILESDIRRELATIVETOHOME=$PWD
export DOTFILESDIRRELATIVETOHOME=dotfiles
echo "DOTFILESDIRRELATIVETOHOME = $DOTFILESDIRRELATIVETOHOME"

pushd ~

#  Ubuntu-only stuff.
if   [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
echo ">>> Installing zsh"
# Install zsh
sudo apt-get install -y zsh
fi  

#launch zsh
zsh

# get prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# Create a new Zsh configuration by copying the Zsh configuration files provided
ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -s ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
ln -s ~/.zprezto/runcoms/zshrc ~/.zshrc
# Copy custom theme
cp ~/dotfiles/prompt_superlinh_setup ~/.zprezto/modules/prompt/functions/prompt_superlinh_setup

symlinkifne .shellvars
symlinkifne .shellpaths
symlinkifne .shellaliases
symlinkifne .profile
symlinkifne .bash_profile
symlinkifne .vim
symlinkifne .zpreztorc
symlinkifne .vimrc
symlinkifne .zshrc
symlinkifne .gitconfig
symlinkifne .tmux.conf

cd dotfiles/

echo "Initializing submodules..."
git submodule init && git submodule update
echo "Submodules installed"

popd

chsh -s /bin/zsh
source ~/.zshrc

echo "Dotfiles are now installed."
