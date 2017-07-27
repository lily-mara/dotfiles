source $HOME/.dotfiles/dont-unstow-me/antigen.zsh

antigen use oh-my-zsh

antigen theme avit

antigen bundle git
antigen bundle ssh-agent
antigen bundle z
antigen bundle pip
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle lukechilds/zsh-nvm


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.profile ] && source ~/.profile

source ~/.aliases
alias ls=exa

antigen apply
