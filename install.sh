#!/bin/bash

sudo apt-get install vim python-pip ack-grep
sudo -H pip install --upgrade pip
sudo -H pip install --upgrade jedi

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

