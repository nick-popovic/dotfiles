#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias lg='lazygit'

PS1='[\u@\h \W]\$ '


export EDITOR="nvim"
export PATH="$PATH:$(go env GOPATH)/bin"

eval "$(starship init bash)"
