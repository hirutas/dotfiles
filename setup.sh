#!/bin/bash
# --------------------------------------
# Symbolic links
# --------------------------------------
# Target lists
FILES=(.vim .vimrc .gvimrc .screenrc .tmux.conf .zsh .zprofile .zshenv .zshrc .git-completion.bash .git-prompt.sh)

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
# OS specific
# --------------------------------------
case ${OSTYPE} in
    # for BSD (mac)
    darwin*)
        # To fix miss configuration of Mac OS X 10.7
        if [ -f /etc/zshenv ]; then
            echo "Fix miss configuration"
            sudo mv -iv /etc/zshenv /etc/zprofile
        fi
        ;;
    # for linux
    linux*)
        ;;
esac


# --------------------------------------
# vim
# --------------------------------------
# Install neobundle.vim
if [ ! -d ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi
# Force update neobundle modules
vim -c 'NeoBundleClean' -c quit
vim -c 'NeoBundleInstall!' -c quit
