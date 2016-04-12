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

export GOROOT=$HOME/.programs/go
export MULTIRUST=$HOME/.multirust/toolchains
export CARGO_STABLE_BIN=$MULTIRUST/stable/cargo/bin
export CARGO_BETA_BIN=$MULTIRUST/beta/cargo/bin
export CARGO_NIGHTLY_BIN=$MULTIRUST/nightly/cargo/bin
export CARGO_BIN=$CARGO_STABLE_BIN:$CARGO_BETA_BIN:$CARGO_NIGHTLY_BIN

export GOPATH=$HOME/gocode
export GO_BIN=$GOPATH/bin
export CABAL_BIN=$HOME/.cabal/bin
export CONDA_BIN=$HOME/.programs/anaconda3/bin

export FLAKE8_IGNORE="W191"
export EDITOR="/usr/bin/vim"
export PATH="/usr/local/heroku/bin:$HOME/.bin:$CABAL_BIN:$GO_BIN:$CARGO_BIN:$CONDA_BIN:$PATH"
[ -f /home/nate/.travis/travis.sh ] && source /home/nate/.travis/travis.sh

which exa >> /dev/null
if [[ $? -eq "0" ]]; then
	alias ls=$(which exa)
else
	alias ls='ls --group-directories-first --color=auto'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
