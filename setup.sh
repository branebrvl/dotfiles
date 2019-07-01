#!
;/bin/bash

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

export DOTFILESDIRRELATIVETOHOME=$PWD
export DOTFILESDIRRELATIVETOHOME=dotfiles
echo "DOTFILESDIRRELATIVETOHOME = $DOTFILESDIRRELATIVETOHOME"

pushd $HOME

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
ln -s $HOME/.zprezto/runcoms/zlogin $HOME/.zlogin
ln -s $HOME/.zprezto/runcoms/zlogout $HOME/.zlogout
ln -s $HOME/.zprezto/runcoms/zpreztorc $HOME/.zpreztorc
ln -s $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile
ln -s $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv
ln -s $HOME/.zprezto/runcoms/zshrc $HOME/.zshrc
# Copy custom theme
cp $HOME/dotfiles/prompt_superlinh_setup $HOME/.zprezto/modules/prompt/functions/prompt_superlinh_setup

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
source $HOME/.zshrc

echo "Dotfiles are now installed."
