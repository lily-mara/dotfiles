bindir=/usr/bin
dotfiles_dir=$(shell pwd)

links=$(HOME)/.bash_aliases $(HOME)/.bashrc $(HOME)/.tmux.conf $(HOME)/.dotfiles $(bindir)/suspend $(bindir)/screenfetch $(bindir)/speedtest

all : $(links)
	. $(HOME)/.bashrc

$(bindir)/speedtest : bin/speedtest/speedtest
	sudo ln -s $(dotfiles_dir)/bin/speedtest/speedtest $(bindir)/speedtest

$(bindir)/screenfetch : bin/screenfetch/screenfetch-dev
	sudo ln -s $(dotfiles_dir)/bin/screenfetch/screenfetch-dev $(bindir)/screenfetch

$(bindir)/suspend : bin/suspend.sh
	sudo ln -s $(dotfiles_dir)/bin/suspend.sh $(bindir)/suspend

$(HOME)/.bash_aliases : aliases
	ln -s $(dotfiles_dir)/aliases ~/.bash_aliases
	
$(HOME)/.bashrc : bashrc
	ln -s $(dotfiles_dir)/bashrc ~/.bashrc
	
$(HOME)/.tmux.conf : tmux.conf
	ln -s $(dotfiles_dir)/tmux.conf ~/.tmux.conf

$(HOME)/.dotfiles :
	ln -s $(dotfiles_dir) ~/.dotfiles

remake : clean all

clean : 
	rm $(links)
