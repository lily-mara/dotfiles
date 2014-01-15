dotfiles=$(HOME)/.bash_aliases $(HOME)/.bashrc $(HOME)/.tmux.conf

all : $(dotfiles)

$(HOME)/.bash_aliases : bash_aliases
	ln -s ~/git/dotfiles/bash_aliases ~/.bash_aliases
	
$(HOME)/.bashrc : bashrc
	ln -s ~/git/dotfiles/bashrc ~/.bashrc
	
$(HOME)/.tmux.conf : tmux.conf
	ln -s ~/git/dotfiles/tmux.conf ~/.tmux.conf

clean : 
	rm $(dotfiles)
