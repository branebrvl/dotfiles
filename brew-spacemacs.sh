#!/bin/bash

# install command line tools
# xcode-select --install

# install homegrew
# ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Check every is configured properly
# brew doctor
brew update

brew tap d12frosted/emacs-plus
brew install emacs-plus --HEAD --with-natural-title-bars
brew linkapps emacs-plus

cd ~
mv .emacs.d .emacs.d.bak
mv .emacs .emacs.bak

cd -
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

emacs --insecure
