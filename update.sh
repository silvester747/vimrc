#!/bin/bash
git pull

sudo -H pip install --upgrade pip
sudo -H pip install --upgrade powerline-status
sudo -H pip install --upgrade jedi

curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle/vim-wombat256mod
git pull
cd ~/.vim/bundle/ctrlp.vim
git pull
cd ~/.vim/bundle/jedi-vim
git pull
cd ~/.vim/bundle/nerdtree
git pull
