# fino-time.zsh-theme

# Use with a dark background and 256-color terminal!
# Meant for people with RVM and git. Tested only on OS X 10.7.

# You can set your computer name in the ~/.box-name file if you want.

# Borrowing shamelessly from these oh-my-zsh themes:
#   bira
#   robbyrussell
#
# Also borrowing from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

function virtualenv_info {
    [ $CONDA_DEFAULT_ENV ] && echo "($CONDA_DEFAULT_ENV) "
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '⠠⠵' && return
    echo '○'
}

function box_name {
  local box="${SHORT_HOST:-$HOST}"
  [[ -f ~/.box-name ]] && box="$(< ~/.box-name)"
  echo "${box:gs/%/%%}"
}

git_prompt_new() {
     if [ -d $__git_repo_path ]; then	
        new=$(git status --porcelain 2>/dev/null | grep '^??' | wc -l)
        
        if [ "$new" -gt 0 ]; then
            echo "+$new "
        fi
    fi
}

git_prompt_modified() {
     if [ -d $__git_repo_path ]; then	
        modified=$(git status --porcelain 2>/dev/null | grep '^ M' | wc -l) 
        
        if [ "$modified" -gt 0 ]; then
            echo "*$modified "
        fi
    fi
}

git_prompt_deleted() {
     if [ -d $__git_repo_path ]; then	
        deleted=$(git status --porcelain 2>/dev/null | grep '.*D' | wc -l)
        
        if [ "$deleted" -gt 0 ]; then
            echo "-$deleted "
        fi
    fi
}

git_prompt_staged() {
     if [ -d $__git_repo_path ]; then	
        staged=$(git status --porcelain 2>/dev/null | grep '^[AMR]' | wc -l)
        
        if [ "$staged" -gt 0 ]; then
            echo "~$staged "
        fi
    fi
}

PROMPT="╭─%{$FG[040]%}%n%{$reset_color%} %{$FG[239]%}at%{$reset_color%} %{$FG[033]%}$(box_name)%{$reset_color%} %{$FG[239]%}in%{$reset_color%} %{$terminfo[bold]$FG[226]%}%~%{$reset_color%}\$(git_prompt_info) %{$FG[021]%}\$(git_prompt_new)%{$FG[208]%}\$(git_prompt_modified)%{$FG[196]%}\$(git_prompt_deleted)%{$FG[046]%}\$(git_prompt_staged)%{$reset_color%}\$(ruby_prompt_info)
╰─\$(virtualenv_info)\$(prompt_char) "

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[239]%}on%{$reset_color%} %{$fg[255]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[202]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%}✔"
ZSH_THEME_RUBY_PROMPT_PREFIX=" %{$FG[239]%}using%{$FG[243]%} ‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"
