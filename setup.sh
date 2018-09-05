#!/bin/bash
# --------------------------------------
# Symbolic links
# --------------------------------------
# Target lists
FILES=(.vim .vimrc .screenrc .tmux.conf .git-completion.bash .git-prompt.sh)

# Create symbolic links
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

# --------------------------------------
# vim
# --------------------------------------
# Install neobundle.vim
if [ ! -d ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
  git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
# Force update neobundle modules
vim -c 'NeoBundleClean' -c quit
vim -c 'NeoBundleInstall!' -c quit
