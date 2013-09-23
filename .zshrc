# --------------------------------------
# General settings
# --------------------------------------
setopt auto_pushd
setopt correct
setopt pushd_ignore_dups
setopt no_beep
setopt prompt_subst
bindkey -e                # emacs like keybind

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


# --------------------------------------
# Completion
# --------------------------------------
autoload -Uz compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # ignore case
zstyle ':completion:*:default' menu select           # select from menu
bindkey "^[[Z" reverse-menu-complete                 # Shift-Tab

# git
zstyle ':completion:*:*:git:*' script ~/.git-completion.bash

# --------------------------------------
# History
# --------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt share_history
setopt hist_ignore_dups
setopt hist_reduce_blanks

# show all histories
function history-all { history -E 1 }

# history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# --------------------------------------
# Prompt
# --------------------------------------
autoload -U colors; colors

PS1="[${USER}@${HOST%%.*}]%(!.#.$) "

# git
source ~/.git-prompt.sh
fpath=(~/.zsh $fpath)

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b) '
zstyle ':vcs_info:*' actionformats '(%b|%a) '
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)%{${fg[blue]}%}[%~]%{${reset_color}%}"

# Terminal title (user@hostname)
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac


# --------------------------------------
# ls
# --------------------------------------
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


# --------------------------------------
# alias
# --------------------------------------
alias p='popd'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'

# git
alias gb="git branch"
alias gst="git status"
alias gad="git add"
alias gcm="git commit"
alias gdf="git diff"
alias gco="git checkout"

# global alias
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'

# --------------------------------------
# OS specific
# --------------------------------------
case ${OSTYPE} in
    # for BSD (mac)
    darwin*)
        ;;
    # for linux
    linux*)
        ;;
esac


# vim:set ft=zsh :
