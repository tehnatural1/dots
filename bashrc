#
# ~/.bashrc
#

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ocaml='rlwrap ocaml'


RED="\[\e[0;36m\]"
GRAY="\[\e[0;37m\]"
YELLOW="\[\e[0;33m\]"
DARK_YELLOW="\[\e[38;5;214m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
GREEN="\[\e[0;32m\]"
WHITE="\[\e[0;37m\]"
BLOODRED="\[\e[1;31m\]"
CYAN="\[\e[1;34m\]"

LIGHT_CYAN="\[\e[38;5;14m\]"
LIGHT_GREEN="\[\e[1;32m\]"

TXTRST="\[\e[0m\]"
BOLD="\[$(tput bold)\]"

DOWNBAR='\342\224\214'
HORBAR='\342\224\200'
UPBAR='\342\224\224'
HORBARPLUG='\342\225\274'
CROSS='\342\234\227'

function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function git_module {
    if [[ $(git status 2> /dev/null) ]]
    then
        echo $WHITE$HORBAR[$PURPLE$(parse_git_branch)$WHITE];
    fi
 }

function file_module {
    echo $HORBAR[$LIGHT_GREEN$(ls | wc -l) files, $(ls -lah | grep -m 1 total | sed 's/total //')$WHITE]
}

function end_module {
    echo "\n"$WHITE$UPBAR$HORBAR$HORBAR$HORBARPLUG $TXTRST
}

function begin_module {
        if [[ $? != 0 ]]
        then
                echo "\n"$WHITE$DOWNBAR$HORBAR[$BLOODRED$CROSS$WHITE]
        else
                echo "\n"$WHITE$DOWNBAR$HORBAR
        fi
}

function user_module {
        echo $HORBAR[$(if [[ ${EUID} == 0 ]]; then echo $BLOODRED'\h'; else echo $BLOODRED'\u'; fi)$WHITE]
}

function location_module {
    echo $HORBAR[$BLUE$BOLD'\w'$WHITE]
}

function time_module {
        echo $HORBAR[$YELLOW$BOLD'\t'$WHITE]
}

function set_bash_prompt {
        PS1=$(begin_module)$(user_module)$(time_module)$(location_module)$(git_module)$(file_module)$(end_module)
}

PROMPT_COMMAND=set_bash_prompt
