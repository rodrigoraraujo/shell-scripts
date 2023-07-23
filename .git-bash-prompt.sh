#!bin/bash

############################# 
#####                   #####
#####  Git Prompt Info  #####
#####                   #####
#############################

git_find_repo_path ()
{
	if [ -n "${__git_repo_path-}" ]; then
		# we already know where it is
		return
	fi

	if [ -n "${__git_C_args-}" ]; then
		__git_repo_path="$(git "${__git_C_args[@]}" \
			${__git_dir:+--git-dir="$__git_dir"} \
			rev-parse --absolute-git-dir 2>/dev/null)"
	elif [ -n "${__git_dir-}" ]; then
		test -d "$__git_dir" &&
		__git_repo_path="$__git_dir"
	elif [ -n "${GIT_DIR-}" ]; then
		test -d "$GIT_DIR" &&
		__git_repo_path="$GIT_DIR"
	elif [ -d .git ]; then
		__git_repo_path=.git
	else
		__git_repo_path="$(git rev-parse --git-dir 2>/dev/null)"
	fi
}

git_find_repo_path

git_branch() {   

    if [ -d $__git_repo_path ]; then	
           branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        if [ $? -eq 0 ]; then
           echo " ($branch)"
        fi
    fi	
}

git_prompt_new() {
     if [ -d $__git_repo_path ]; then	
        new=$(git status --porcelain 2>/dev/null | grep '^??' | wc -l)
        
        if [ "$new" -gt 0 ]; then
            echo " +$new"
        fi
    fi
}

git_prompt_modified() {
     if [ -d $__git_repo_path ]; then	
        modified=$(git status --porcelain 2>/dev/null | grep '^ M' | wc -l) 
        
        if [ "$modified" -gt 0 ]; then
            echo " *$modified"
        fi
    fi
}

git_prompt_deleted() {
     if [ -d $__git_repo_path ]; then	
        deleted=$(git status --porcelain 2>/dev/null | grep '.*D' | wc -l)
        
        if [ "$deleted" -gt 0 ]; then
            echo " -$deleted"
        fi
    fi
}

git_prompt_staged() {
     if [ -d $__git_repo_path ]; then	
        staged=$(git status --porcelain 2>/dev/null | grep '^[AMR]' | wc -l)
        
        if [ "$staged" -gt 0 ]; then
            echo " ~$staged"
        fi
    fi
}

PS1='\[\e[1m\e[32m\]\u@\h\[\e[0m\]:\[\e[1m\e[34m\]\w\[\e[33m\]$(git_branch)\[\e[0m\]\[\e[0m\e[36m\]$(git_prompt_new)\[\e[0m\e[35m\]$(git_prompt_modified)\[\e[0m\e[31m\]$(git_prompt_deleted)\[\e[0m\e[32m\]$(git_prompt_staged)\[\e[0m\]\$ '
