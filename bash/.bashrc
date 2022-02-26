#!bin/bash
# my super awesome ~/.bashrc :)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

NONE="$(tput sgr0)"
YELLOW="$(tput setaf 222)"
GREEN="$(tput setaf 156)"

alias ls='ls --color=auto'
alias which='type -P'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# this is supposed to put a ":(" at the end of the line if a command comes up with a failure status, like in the arch linux install iso
# haven't gotten it to work, unfortunately. doesn't hurt to keep it in here, though.
# https://wiki.archlinux.org/title/Bash/Prompt_customization
PS1='\[$(tput sc; [ $? -ne 0 ] && printf "%*s" $COLUMNS ":("; tput rc)\]${YELLOW}\u${NONE}@${GREEN}\h${NONE} \W$(parse_git_branch) \$ '

# csv viewer in terminal
# stolen from https://stackoverflow.com/a/24414806
csview() {
    local file="$1"
    cat "$file" | sed -e 's/,,/, ,/g' | column -s, -t | less -#5 -N -S
}

