#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

cd() {
	if builtin cd "$@"; then
		lsd
	fi
}

alias ls='lsd'
alias grep='grep --color=auto'
PS1='[\W]\$ '
alias config='/usr/bin/git --git-dir=/home/sed/.cfg/ --work-tree=/home/sed'
