#!/bin/bash

sudo apt-get install vim python-pip
sudo -H pip install --upgrade pip
sudo -H pip install powerline-status
sudo -H pip install jedi

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone https://github.com/michalbachowski/vim-wombat256mod.git ~/.vim/bundle/vim-wombat256mod
git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
