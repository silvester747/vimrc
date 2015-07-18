#!/bin/bash

sudo apt-get install vim python-pip
sudo -H pip install --upgrade pip
sudo -H pip install powerline-status

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
