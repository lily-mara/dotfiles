dotfiles=/home/nate/.bash_aliases /home/nate/.bashrc /home/nate/.tmux.conf

all : $(dotfiles)

/home/nate/.bash_aliases : bash_aliases
	ln -s ~/git/dotfiles/bash_aliases ~/.bash_aliases
	
/home/nate/.bashrc : bashrc
	ln -s ~/git/dotfiles/bashrc ~/.bashrc
	
/home/nate/.tmux.conf : tmux.conf
	ln -s ~/git/dotfiles/tmux.conf ~/.tmux.conf

clear : 
	rm $(dotfiles)
