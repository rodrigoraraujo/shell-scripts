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
    if is_git_repo; then
        local git_status=$(git status --porcelain)

        local new=$(echo $git_status        | grep '^??'    | wc -l | awk '{ print $1 }')
        local modified=$(echo $git_status   | grep '^ M'    | wc -l | awk '{ print $1 }')
        local deleted=$(echo $git_status    | grep '^ D'    | wc -l | awk '{ print $1 }')
        local staged=$(echo $git_status     | grep '^[AMR]' | wc -l | awk '{ print $1 }')
        local prompt=''

        if [ "$new" -gt 0 ]; then
            prompt="%{$FG[021]%}+$new "
        fi

        if [ "$modified" -gt 0 ]; then
            prompt+="%{$FG[208]%}*$modified "
        fi

        if [ "$deleted" -gt 0 ]; then

^G Get Help                          ^O WriteOut                          ^R Read File                         ^Y Prev Pg                           ^K Cut Text                          ^C Cur Pos                           
^X Exit                              ^J Justify                           ^W Where is                          ^V Next Pg                           ^U UnCut Text                        ^T To Spell                          
