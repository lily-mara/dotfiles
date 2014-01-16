dotfiles_dir=$(shell pwd)
dotfiles_dir_esc=$(shell echo $(dotfiles_dir) | sed -e 's/\//\\\//g')

dotfiles=$(HOME)/.bash_aliases $(HOME)/.bashrc $(HOME)/.tmux.conf

all : $(dotfiles)

$(HOME)/.bash_aliases : bash_aliases
	sed -i -e '1s/DOTFILES_DIR_REPLACE/$(dotfiles_dir_esc)/' bash_alias
	ln -s $(dotfiles_dir)/bash_aliases ~/.bash_aliases
	
$(HOME)/.bashrc : bashrc
	ln -s $(dotfiles_dir)/bashrc ~/.bashrc
	
$(HOME)/.tmux.conf : tmux.conf
	ln -s $(dotfiles_dir)/tmux.conf ~/.tmux.conf

clean : 
	rm $(dotfiles)
	sed -e '1s/$(dotfiles_dir_esc)/DOTFILES_DIR_REPLACE/' bash_alias
