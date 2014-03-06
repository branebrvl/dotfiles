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


# get prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# Create a new Zsh configuration by copying the Zsh configuration files provided
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

symlinkifne .shellvars
symlinkifne .shellpaths
symlinkifne .shellaliases
symlinkifne .profile
symlinkifne .bash_profile
symlinkifne .vim
# symlinkifne .oh-my-zsh
symlinkifne .zpreztorc
symlinkifne .vimrc
symlinkifne .zshrc
symlinkifne .gitconfig
symlinkifne .tmux.conf

ln -s dotfiles/prompt_superlinh_setup "${ZDOTDIR:-$HOME}"/.zprezto/modules/prompt/functions/prompt_superlinh_setup
cd dotfiles/

echo "Initializing submodules..."
git submodule init && git submodule update

popd

chsh -s `which zsh`
/usr/bin/env zsh
source ~/.zshrc

echo "Dotfiles are now installed."
