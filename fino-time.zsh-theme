# fino-time.zsh-theme (Refined Fancy Version)

# Disable automatic prompt modification by Conda/Virtualenv to prevent duplicates
# Our theme handles this via the virtualenv_info function below
export CONDA_CHANGEPS1=no
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Symbols
# Git:  (branch), ● (staged), ✚ (modified), … (untracked), ✖ (deleted)
# Venv:  (python),  (ruby)

# Conda/Virtualenv information
function virtualenv_info {
   if [ -n "$CONDA_DEFAULT_ENV" ]; then
     echo "%{$FG[109]%}🐍 $CONDA_DEFAULT_ENV %{$reset_color%}"
   elif [ -n "$VIRTUAL_ENV" ]; then
     echo "%{$FG[109]%}🐍 $(basename $VIRTUAL_ENV) %{$reset_color%}"
   fi
}

# Machine name handling
function box_name {
  local box="${SHORT_HOST:-$HOST}"
  [[ -f ~/.box-name ]] && box="$(< ~/.box-name)"
  echo "${box:gs/%/%%}"
}

# Custom detailed Git status
function git_prompt_custom() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    
    local git_status=$(git status --porcelain 2>/dev/null)
    [ -z "$git_status" ] && return

    local n=$(echo "$git_status" | grep -c '^??')
    local m=$(echo "$git_status" | grep -c '^ M')
    local d=$(echo "$git_status" | grep -c '^ D')
    local s=$(echo "$git_status" | grep -c '^[AMR]')
    
    local prompt=" "
    [ "$s" -gt 0 ] && prompt+="%{$FG[046]%}●$s "  # Staged
    [ "$m" -gt 0 ] && prompt+="%{$FG[208]%}✚$m "  # Modified
    [ "$n" -gt 0 ] && prompt+="%{$FG[033]%}?$n "  # Untracked
    [ "$d" -gt 0 ] && prompt+="%{$FG[196]%}✖$d "  # Deleted
    
    echo "$prompt%{$reset_color%}"
}

# Prompt character that changes color on failure
function prompt_char {
    local status_color="%(?.%{$FG[040]%}.%{$FG[196]%})"
    echo "$status_color➜ %{$reset_color%}"
}

# Primary prompt (2-line)
PROMPT='╭─ %{$FG[040]%}%n %{$FG[239]%}@ %{$FG[033]%}$(box_name) %{$FG[239]%}in %{$terminfo[bold]$FG[226]%}%~%{$reset_color%}$(git_prompt_info)$(git_prompt_custom)$(ruby_prompt_info)
╰─ $(virtualenv_info)$(prompt_char)'

# Right prompt with current time
RPROMPT='%{$FG[239]%}%D{%H:%M:%S}%{$reset_color%}'

# Git styling for oh-my-zsh git_prompt_info
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[239]%}on %{$terminfo[bold]$fg[white]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[202]%} ✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%} ✔"

# Ruby styling
ZSH_THEME_RUBY_PROMPT_PREFIX=" %{$FG[239]%}using %{$FG[243]%}‹ "
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"


