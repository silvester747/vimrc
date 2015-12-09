#!/bin/bash

sudo apt-get install vim python-pip ack-grep
sudo -H pip install --upgrade pip
sudo -H pip install --upgrade powerline-status
sudo -H pip install --upgrade jedi

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

function clone_or_pull {
  if [ -d "$1" ]; then
    cd "$1"
    git pull
  else
    git clone $2 $1
  fi
}

clone_or_pull ~/.vim/bundle/vim-wombat256mod https://github.com/michalbachowski/vim-wombat256mod.git
clone_or_pull ~/.vim/bundle/ctrlp.vim https://github.com/kien/ctrlp.vim.git
clone_or_pull ~/.vim/bundle/nerdtree https://github.com/scrooloose/nerdtree.git
clone_or_pull ~/.vim/bundle/supertab https://github.com/ervandew/supertab.git
clone_or_pull ~/.vim/bundle/ack.vim https://github.com/mileszs/ack.vim.git
clone_or_pull ~/.vim/bundle/YouCompleteMe "--recursive https://github.com/Valloric/YouCompleteMe.git"

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

