[ -f ~/.profile ] && source ~/.profile

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
if [[ -s "${ZDOTDIR:-$HOME}/.zsh-aliases" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh-aliases"
fi
if [[ -s "${ZDOTDIR:-$HOME}/.zsh/git-flow-completion.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/git-flow-completion.zsh"
fi
echo -ne '\e%G\e[?47h\e%G\e[?47l'
export TERM=xterm-256color
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_dsa' 'id_github'
if [[ -s "/etc/bash_completion.d/pycompletion.sh" ]]; then
	autoload bashcompinit
	bashcompinit
	source /etc/bash_completion.d/pycompletion.sh
fi

[ -f /home/nate/.travis/travis.sh ] && source /home/nate/.travis/travis.sh

which exa >> /dev/null
if [[ $? -eq "0" ]]; then
	alias ls=$(which exa)
else
	alias ls='ls --group-directories-first --color=auto'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
