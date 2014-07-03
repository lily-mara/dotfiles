#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.aliases" ]]; then
  source "${ZDOTDIR:-$HOME}/.aliases"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.dotfiles/zsh/git-flow-completion.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.dotfiles/zsh/git-flow-completion.zsh"
fi

# Customize to your needs...

echo -ne '\e%G\e[?47h\e%G\e[?47l'
export TERM=screen-256color
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_dsa' 'id_github'

if [[ `hostname` == 'reef' ]]
then
	eval `ssh-agent -s`
	ssh-add
fi
