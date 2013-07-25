#!/bin/bash
# Simple setup.sh
ln -s dotfiles/.bash_profile
ln -s dotfiles/.vim
ln -s dotfiles/.oh-my-zsh
ln -s dotfiles/.vimrc
ln -s dotfiles/.zshrc
ln -s dotfiles/.gitconfig
ln -s dotfiles/bin/git_diff_wrapper bin/git_diff_wrapper
echo "Initializing submodules..."
git submodule init && git submodule update
