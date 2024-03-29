# >>> 
#
#   The default shell of the genetics server is tcsh which is not good enough
#       tcsh runs .tcshrc on login
#       I wanted to use zsh so I added following lines to .tcshrc to automatically switch to the zsh shell
#           ```bash
#               echo switching to zsh
#               zsh -i
#           ```
#
#   Then I use current file for the .zshrc which is get run after the zsh starts to work
#       I also automate update .zshrc using the DropBox and Maestral app on the server and a saved snippet on the terminus
#
#   
#   I use $HOME/bulk for installing softwares, python versions, venvs and these kind of manged by pkg manager and not clean stuff but automatically managed stuff
#   I use my personal genetics folder defined below as $MAHDI_DIR for having the DropBox folder, all the code in git format in the and anyother output if I wanted them to get synced I use the DropBox folder
#   
#   I installed the pyenv in the .pyenv in the bulk folder so installing new python versions and pyenvs don't use my 10GB home folder space
#       no need to sudo to install pyenv just git clone the repo
#       I use pyenv to install anyversion of python (even maybe conda versions) and creating and managing the venvs
#       To create venvs the pyenv-virtualenv which is plugin to pyenv must be setup
#   
#   DropBox
#       I install Maestral app using just pip in an isolated and exclusive Maestral app on the server, it has its deamon and ignoring and selective sync functionality
#       I have different setups to determine what should be synced between which computers
#       
#       Deamon
#           I disabled the deamon autostart upon startup.
#           Instead I created a tmux session on the g03 machine which is the dev machine. Inside that session I manually started the deamon.
#             the tmux session I created is window 0
#             I will never kill this session as I want to my files keep getting synced anytime even when I am not logged into servers.
#   
#
#   Completions
#       TODO: make maestral completion work
#       I made the ~/.zsh/completion dir for storing completion.
#       I added the completion code for the maestral to the dir.
#


# >>> SSGAC .bashrc
#   it consists of useful ENV Vars like GEN_ROOT & other aliases
source "/var/genetics/misc/config/.ssgac_bashrc"  # source runs in the current shell unlike the bash which creates a subshell
# revert to original prompt of zsh
PS1=$DEFAULT_PROMPT

# >>> exports
export BULK="$HOME/bulk"
export MAHDI="$WS_HOME/mahdimir"
export DROPBOX="$MAHDI/DropBox"
export LOCAL="$MAHDI/LOCAL"
export EV="$DROPBOX/B-ev"
export GIT_CODE="$EV/A1-git-code"

# >>> f()
mycd() {
  if [[ "$1" == "-" ]]; then
    cd "$@"
  else
    cd "$@" && pwd
  fi
}

# >>> aliases
alias cdd="cd $DROPBOX"
alias cd=mycd

# >>> pyenv
export PYENV_ROOT="$BULK/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)" # using eval to hide ouputs 

# >>> pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"

# >>> completions
# to load completion files from the path
# fpath=(~/.zsh/completion $fpath)
# autoload -U compinit
# compinit