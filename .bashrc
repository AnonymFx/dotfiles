#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -la'
alias cd..='cd ..'
PS1='[\u@\h \W]\$ '
