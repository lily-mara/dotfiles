zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa

source "${HOME}/.dotfiles/dont-unstow-me/zgen/zgen.zsh"

if ! zgen saved; then
	zgen oh-my-zsh

	zgen oh-my-zsh plugins/z
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
		djui/alias-tips
		felixr/docker-zsh-completion
EOPLUGINS

	zgen save
fi

eval "$(starship init zsh)"

# Ctrl-;, as configured by iTerm settings.
bindkey '^[[50~' autosuggest-accept
bindkey '^ ' autosuggest-accept

function src {
	[ -f "${1}" ] && source "${1}"
}

src ~/.fzf.zsh
src ~/.profile
src ~/.aliases
src ~/.clone.zsh

export NVM_DIR="$HOME/.nvm"
src "/usr/local/opt/nvm/nvm.sh"

function _cd_search {
	readonly dir=$(z -l | sort -nr | awk '{ print $2 }' | fzy)
	if [ ! -z $dir ]; then
		cd $dir
	fi
    starship_precmd
	zle reset-prompt
}

zle -N _cd_search
bindkey '^k' _cd_search


function _history_search {
	readonly cmd=$(history | awk '{ $1 = ""; print $0 }' | sed 's/^ *//' | sort | uniq -c | sort -nr | awk '{ $1 = ""; print $0 }' | sed 's/^ *//' | fzy)
	if [ ! -z "${cmd}" ]; then
		zle kill-whole-line
		RBUFFER="${cmd}"
		zle accept-line
	fi
}

zle -N _history_search
bindkey '^r' _history_search

function _branch_search {
	readonly cmd=$(git for-each-ref --format='%(refname:short)' 'refs/heads/*' | fzy)
	if [ ! -z "${cmd}" ]; then
		zle kill-whole-line
		git checkout "${cmd}"
	fi
    starship_precmd
	zle reset-prompt
}

zle -N _branch_search
bindkey '^o' _branch_search

export PATH=/Users/nm46057/.local/bin:$PATH

fpath=(~/.zsh-completions $fpath)

[ -f ~/.gcloud-sdk/path.zsh.inc ] && source ~/.gcloud-sdk/path.zsh.inc
[ -f ~/.gcloud-sdk/completion.zsh.inc ] && source ~/.gcloud-sdk/completion.zsh.inc
