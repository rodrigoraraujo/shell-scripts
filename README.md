## Bash

1. Download `.git-bash-prompt.sh` to the home directory.
##
        wget https://raw.githubusercontent.com/rodrigoraraujo/shell-scripts/main/.git-bash-prompt.sh -P ~/

2. Append the following line into the `.bashrc`
##
        echo ". ~/.git-bash-prompt.sh" >> ~/.bashrc

3. The prompt will change either after restarting the bash shell or executing the command 
##
        source ~/.bashrc

## Zsh

1. Install [Oh My Zsh](https://ohmyz.sh/#install) and change the theme to `fino-time`

2. Download `fino-time.zsh-theme`
##
        wget -O ~/.oh-my-zsh/themes/fino-time.zsh-theme https://raw.githubusercontent.com/rodrigoraraujo/shell-scripts/main/fino-time.zsh-theme

3. The prompt will change either after restarting the bash shell or executing the command
##
        source ~/.zshrc
