source "${HOME}/.dotfiles/dont-unstow-me/zgen/zgen.zsh"

if ! zgen saved; then
    zgen oh-my-zsh

	zgen oh-my-zsh plugins/z
	zgen oh-my-zsh plugins/git
	zgen oh-my-zsh plugins/pip
	zgen oh-my-zsh plugins/sudo
	zgen oh-my-zsh plugins/ssh-agent

	zgen loadall <<EOPLUGINS
		zsh-users/zsh-history-substring-search
		zsh-users/zsh-syntax-highlighting
		zsh-users/zsh-autosuggestions
		zsh-users/zsh-completions
		natemara/af-magic-nate af-magic
		djui/alias-tips
EOPLUGINS

    zgen save
fi

# Ctrl-;, as configured by iTerm settings.
bindkey '^[[50~' autosuggest-accept
bindkey '^ ' autosuggest-accept

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.profile ] && source ~/.profile

source ~/.aliases
alias ls=exa
