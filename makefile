dotfiles_dir=$(shell pwd)

links=$(HOME)/.aliases $(HOME)/.bashrc $(HOME)/.tmux.conf $(HOME)/.dotfiles $(HOME)/.conkyrc

all : $(links)

$(HOME)/.aliases : aliases
	ln -s $(dotfiles_dir)/aliases ~/.aliases
	
$(HOME)/.bashrc : bashrc
	ln -s $(dotfiles_dir)/bashrc ~/.bashrc
	
$(HOME)/.tmux.conf : tmux.conf
	ln -s $(dotfiles_dir)/tmux.conf ~/.tmux.conf

$(HOME)/.conkyrc : conkyrc
	ln -s $(dotfiles_dir)/conkyrc ~/.conkyrc

$(HOME)/.dotfiles :
	ln -s $(dotfiles_dir) ~/.dotfiles

remake : clean all

clean :
	rm $(links)
