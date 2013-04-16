#!/bin/bash

FILES=(.vim .vimrc .gvimrc .screenrc)

for file in ${FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done
