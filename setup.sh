#!/bin/bash

# Create symbolic links
FILES=(.vim .vimrc .gvimrc .screenrc .tmux.conf)

for file in ${FILES[@]}
do
  origfile=$HOME/$file
  if [ -L ${origfile} ]; then
    echo "Remove existing symbolic link"
    rm -v ${origfile}
  elif [ -f ${origfile} -o -d ${origfile} ]; then
    echo "Backup original file"
    mv ${origfile} ${origfile}_`date +%Y%m%d`
  fi

  echo "Create symbolic link: $HOME/$file"
  ln -s $HOME/dotfiles/$file $HOME/$file
done

# Install neobundle.vim
if [ ! -d ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi
vim -c 'NeoBundleInstall!' -c quit
