# --------------------------------------
# Global
# --------------------------------------
export LANG=en_US.UTF-8

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# --------------------------------------
# OS specific
# --------------------------------------
case ${OSTYPE} in
    # for BSD (mac)
    darwin*)
        export PATH=$PATH:/Users/$USER/bin
        export PATH=$PATH:/usr/texbin
        export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
        # Use GNU coreutils
        export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
        ;;
    # for linux
    linux*)
        ;;
esac


