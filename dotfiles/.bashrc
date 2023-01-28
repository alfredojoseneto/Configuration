# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias lsbw='ls --color=never'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Tmux as default when open a new shell
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

# export the PATH
export PATH="$PATH:$HOME/.local/opt"


parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}


# STARTCOLOR='\[\e[1;36m\]';
# ORANGECOLOR='\[\e[1;33m\]';
# PURPLECOLOR='\[\e[1;35m\]'
# ENDCOLOR="\[\e[0m\]"
# STARTLINE="\342\224\214\342\224\200"
# ENDLINE="\342\224\224\342\224\200\342\224\200\342\225\274"
# export PS1="$STARTCOLOR$STARTLINE \u$ORANGECOLOR@$ENDCOLOR$STARTCOLOR\h[$ORANGECOLOR\w$ENDCOLOR$PURPLECOLOR$(parse_git_branch)$ENDCOLOR]\n$ENDLINE$ENDCOLOR$STARTCOLOR \$$ENDCOLOR "

# export PS1='\[\e[1;36m\]\342\224\214\342\224\200\[\e[1;36m\][\[\e[1;36m\]\u\[\e[1;33m\]@\[\e[1;37m\]\h\[\e[1;36m\]]\[\e[1;36m\]\342\224\200\[\e[1;36m\][\[\e[1;37m\]\w\[\e[1;36m\]]\n\[\e[1;36m\]\342\224\224\342\224\200\342\224\200\342\225\274\[\e[1;32m\] \$ \[\e[0m\]'

# -------------------- display git branch -------------------------------------

# export PS1="\e[0;31m[\u@\h \W] \$ \e[m "
# export PS1="$(inicio_cor)[\u@\h \W] \$ \e[m"

# export PS1='\[\e[1;36m\]\342\224\214\342\224\200\[\e[1;36m\][\[\e[1;36m\]\u\[\e[1;33m\]@\[\e[1;37m\]\h\[\e[1;36m\]]\[\e[1;36m\]\342\224\200\[\e[1;36m\][\[\e[1;37m\]\w\[\e[1;36m\]]\n\[\e[1;36m\]\342\224\224\342\224\200\342\224\200\342\225\274\[\e[1;32m\] \$ \[\e[0m\]'
# export PS1="[\h@\u]-[\w\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')]\\$\[$(tput sgr0)\]"
 
 
 
#==============================================================================
#-------------------- PS1 BASH ------------------------------------------------
#==============================================================================
# # prompt
FMT_BOLD="\[\e[1m\]"
FMT_DIM="\[\e[2m\]"
FMT_RESET="\[\e[0m\]"
FMT_UNBOLD="\[\e[22m\]"
FMT_UNDIM="\[\e[22m\]"
FG_BLACK="\[\e[30m\]"
FG_BLUE="\[\e[34m\]"
FG_CYAN="\[\e[36m\]"
FG_GREEN="\[\e[32m\]"
FG_GREY="\[\e[37m\]"
FG_MAGENTA="\[\e[35m\]"
FG_RED="\[\e[31m\]"
FG_WHITE="\[\e[97m\]"
BG_BLACK="\[\e[40m\]"
BG_BLUE="\[\e[44m\]"
BG_CYAN="\[\e[46m\]"
BG_GREEN="\[\e[42m\]"
BG_MAGENTA="\[\e[45m\]"
BG_RED="\[\e[41m\]"
STARTLINE="\342\224\214\342\224\200"
ENDLINE="\342\224\224\342\224\200\342\224\200\342\225\274"

parse_git_bg() {
	[[ $(git status -s 2> /dev/null) ]] && echo -e "\e[43m" || echo -e "\e[42m"
}

parse_git_fg() {
	[[ $(git status -s 2> /dev/null) ]] && echo -e "\e[33m" || echo -e "\e[32m"
}

# PS1="\n${FG_BLUE}╭─" # begin arrow to prompt
PS1="\n${FG_BLUE}$STARTLINE" # begin arrow to prompt
# PS1+="${FG_MAGENTA}" # begin USERNAME container
PS1+="${FG_MAGENTA}" # begin USERNAME container
# PS1+="${BG_MAGENTA}${FG_CYAN}${FMT_BOLD}  " # print OS icon
PS1+="${BG_MAGENTA}${FG_RED}${FMT_BOLD}  " # print OS icon
# PS1+="${BG_RED}${FG_WHITE}${FMT_BOLD}  " # print OS icon  --->>> apply this for root
PS1+="${FG_WHITE} \u" # print username
PS1+=" @ "
PS1+="  \h"
# PS1+="${FMT_UNBOLD} ${FG_MAGENTA}${BG_BLUE} " # end USERNAME container / begin DIRECTORY container
# PS1+="${FMT_BOLD} ${FG_MAGENTA}${BG_BLUE} " # end USERNAME container / begin DIRECTORY container
PS1+="${FMT_UNBOLD} ${FG_MAGENTA}${BG_BLUE} " # end USERNAME container / begin DIRECTORY container
PS1+="${FG_GREY}\w " # print directory
# PS1+="${FG_BLUE}${BG_CYAN} " # end DIRECTORY container / begin FILES container
PS1+="${FG_BLUE}${BG_CYAN} " # end DIRECTORY container / begin FILES container
PS1+="${FG_BLACK}"
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type d | wc -l) " # print number of folders
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type f | wc -l) " # print number of files
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type l | wc -l) " # print number of symlinks
PS1+="${FMT_RESET}${FG_CYAN}"
PS1+="\$(git branch 2> /dev/null | grep '^*' | colrm 1 2 | xargs -I BRANCH echo -n \"" # check if git branch exists
# PS1+="\$(parse_git_bg) " # end FILES container / begin BRANCH container
PS1+="\$(parse_git_bg) " # end FILES container / begin BRANCH container
PS1+="${FG_BLACK} BRANCH " # print current git branch
# PS1+="${FMT_RESET}\$(parse_git_fg)\")\n" # end last container (either FILES or BRANCH)
PS1+="${FMT_RESET}\$(parse_git_fg)\")\n" # end last container (either FILES or BRANCH)
# PS1+="${FG_BLUE}╰ " # end arrow to prompt
PS1+="${FG_BLUE}$ENDLINE " # end arrow to prompt
PS1+="${FG_CYAN}\\$ " # print prompt
PS1+="${FMT_RESET}"
export PS1
