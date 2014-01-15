DOTFILES='/home/nate/git/dotfiles'

#VIM!
alias vim='vim -X'
alias vi='vim -X'

#this file
alias reloada='. ~/.bashrc'
alias edita='vim -X ~/.bash_aliases'
alias commita='$DOTFILES/bin/git_scripts/commit_aliases.sh'

#system functions
alias reboot='sudo shutdown -r now'

#scripts
alias nn='$DOTFILES/bin/class-notes/class-notes.sh'
alias gc='$DOTFILES/bin/git_scripts/git_check.sh ~/git/'
alias renTag='$DOTFILES/bin/git_scripts/rename_tag.sh'
alias gg='$DOTFILES/bin/git_scripts/gist_commit.sh'

#tmux
alias tls='tmux list-sessions'
alias tat='tmux attach -t'
alias tn='tmux new -s'
alias ts='$DOTFILES/bin/tmux-session.sh'
