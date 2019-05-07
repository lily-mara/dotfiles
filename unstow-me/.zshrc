zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa id_gitlab_push

source "${HOME}/.dotfiles/dont-unstow-me/zgen/zgen.zsh"

if ! zgen saved; then
	zgen oh-my-zsh

	zgen oh-my-zsh plugins/z
	zgen oh-my-zsh plugins/git
	zgen oh-my-zsh plugins/pip
	zgen oh-my-zsh plugins/ssh-agent
	zgen oh-my-zsh plugins/rust
	zgen oh-my-zsh plugins/cargo
	zgen oh-my-zsh plugins/nvm

	zgen loadall <<EOPLUGINS
		zsh-users/zsh-history-substring-search
		zsh-users/zsh-syntax-highlighting
		zsh-users/zsh-autosuggestions
		zsh-users/zsh-completions
		esc/conda-zsh-completion
		natemara/af-magic-nate af-magic
		djui/alias-tips
		felixr/docker-zsh-completion
EOPLUGINS

	zgen save
fi

# Ctrl-;, as configured by iTerm settings.
bindkey '^[[50~' autosuggest-accept
bindkey '^ ' autosuggest-accept

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.profile ] && source ~/.profile

function _cd_search {
	readonly dir=$(z -l | sort -nr | awk '{ print $2 }' | fzy)
	if [ ! -z $dir ]; then
		cd $dir
	fi
	zle reset-prompt
}

zle -N _cd_search
bindkey '^k' _cd_search

source ~/.aliases
source ~/.clone.zsh
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

export PATH=/Users/nm46057/.local/bin:$PATH

fpath=(~/.zsh-completions $fpath)

[ -f ~/.gcloud-sdk/path.zsh.inc ] && source ~/.gcloud-sdk/path.zsh.inc
[ -f ~/.gcloud-sdk/completion.zsh.inc ] && source ~/.gcloud-sdk/completion.zsh.inc
