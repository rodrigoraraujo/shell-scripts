#!bin/bash
################################# 
#####  Git Prompt Info ##########
#################################

RESET="\033[0m"
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

BRIGHT_BLACK="\033[1;30m"
BRIGHT_RED="\033[1;31m"
BRIGHT_GREEN="\033[1;32m"
BRIGHT_YELLOW="\033[1;33m"
BRIGHT_BLUE="\033[1;34m"
BRIGHT_PURPLE="\033[1;35m"
BRIGHT_CYAN="\033[1;36m"
BRIGHT_WHITE="\033[1;37m"

git_branch() {   

    if [ -d $__git_repo_path ]; then	
           branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        if [ $? -eq 0 ]; then
           echo -e " ${BRIGHT_YELLOW}($branch)${RESET}"
        fi
    fi	
}

is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
}

git_prompt() {
    if is_git_repo; then
        # git_status="$(git status --porcelain 2> /dev/null)"
        git_status=$(git status --porcelain 2>/dev/null)        

        local new=$(printf "%s\n" "$git_status"         | grep '^??' | wc -l)
        local modified=$(printf "%s\n" "$git_status"    | grep '^ M'    | wc -l) 
        local deleted=$(printf "%s\n" "$git_status"     | grep '^ D'    | wc -l)
        local staged=$(printf "%s\n" "$git_status"      | grep '^[AMR]' | wc -l)
        local prompt=''
        
        if [ "$new" -gt 0 ]; then
            prompt="${BLUE}+$new "
        fi

        if [ "$modified" -gt 0 ]; then
            prompt+="${YELLOW}*$modified "
        fi
        
        if [ "$deleted" -gt 0 ]; then
            prompt+="${RED}-$deleted "
        fi

        if [ "$staged" -gt 0 ]; then
            prompt+="${GREEN}~$staged "
        fi

        echo -e " $prompt${RESET}"            
    fi
}

PS1='\[\e[1m\e[32m\]\u@\h\[\e[0m\]:\[\e[1m\e[34m\]\w\[\e[0m\]$(git_branch)$(git_prompt)$ '
