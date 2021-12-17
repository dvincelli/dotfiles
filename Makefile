all: bashrc bin screenrc tmux mysql vimrc gitprompt agignore

bin:
	mkdir -p ~/bin

agignore:
	ln -s agignore ~/.agignore

bashrc:
	ln -s bashrc ~/.bashrc
	ln -s bashrc.colors ~/.bashrc.colors

screenrc:
	ln -s screenrc ~/.screenrc

tmux:
	ln -s tmux.conf ~/.tmux.conf

mysql:
	ln -s my.cnf ~/.my.cnf

vimrc:
	ln -s vimrc ~/.vimrc
	ln -s gvimrc ~/.gvimrc
	mkdir -p ~/.vim/plugin
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

gitprompt:
	curl -L -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh

.PHONY: all ackrc bashrc bin screenrc tmux mysql vimrc
