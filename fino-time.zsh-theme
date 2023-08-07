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

is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
}

git_prompt() {
    git_status=$(git status --porcelain)

    if is_git_repo; then	
        local new=$(echo $git_status        | grep '^??'    | wc -l)
        local modified=$(echo $git_status   | grep '^ M'    | wc -l) 
        local deleted=$(echo $git_status    | grep '^ D'    | wc -l)
        local staged=$(echo $git_status     | grep '^[AMR]' | wc -l)
        local prompt=''
        
        if [ "$new" -gt 0 ]; then
            prompt="%{$FG[021]%}+$new "
        fi

        if [ "$modified" -gt 0 ]; then
            prompt+="%{$FG[208]%}*$modified "
        fi
        
        if [ "$deleted" -gt 0 ]; then
            prompt+="%{$FG[196]%}-$deleted "
        fi

        if [ "$staged" -gt 0 ]; then
            prompt+="%{$FG[046]%}~$staged "
        fi

        echo "$prompt%{$reset_color%}"            
    fi
}

PROMPT="╭─%{$FG[040]%}%n%{$reset_color%} %{$FG[239]%}at%{$reset_color%} %{$FG[033]%}$(box_name)%{$reset_color%} %{$FG[239]%}in%{$reset_color%} %{$terminfo[bold]$FG[226]%}%~%{$reset_color%}\$(git_prompt_info) \$(git_prompt)\$(ruby_prompt_info)
╰─\$(virtualenv_info)\$(prompt_char) "

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[239]%}on%{$reset_color%} %{$fg[255]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[202]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%}✔"
ZSH_THEME_RUBY_PROMPT_PREFIX=" %{$FG[239]%}using%{$FG[243]%} ‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"
