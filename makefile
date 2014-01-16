dotfiles_dir=$(shell pwd)
dotfiles=$(HOME)/.bash_aliases $(HOME)/.bashrc $(HOME)/.tmux.conf

all : $(dotfiles)

$(HOME)/.bash_aliases : bash_aliases
	ln -s $(dotfiles_dir)/bash_aliases ~/.bash_aliases
	
$(HOME)/.bashrc : bashrc
	ln -s $(dotfiles_dir)/bashrc ~/.bashrc
	
$(HOME)/.tmux.conf : tmux.conf
	ln -s $(dotfiles_dir)/tmux.conf ~/.tmux.conf

clean : 
	rm $(dotfiles)
