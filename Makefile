all: ackrc bashrc bin screenrc tmux mysql vimrc gitprompt

bin:
	mkdir -p ~/bin

ackrc: bin
	[ -e ~/bin/ack ] || curl -L -s http://betterthangrep.com/ack-standalone > ~/bin/ack && chmod 0755 ~/bin/ack
	cp ackrc ~/.ackrc

bashrc:
	cp bashrc ~/.bashrc
	cp bashrc.colors ~/.bashrc.colors

screenrc:
	cp screenrc ~/.screenrc

tmux:
	cp tmux.conf ~/.tmux.conf

mysql:
	cp my.cnf ~/.my.cnf

vimrc:
	cp vimrc ~/.vimrc
	cp gvimrc ~/.gvimrc
	mkdir -p ~/.vim/plugin
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

gitprompt:
	curl -L -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh

.PHONY: all ackrc bashrc bin screenrc tmux mysql vimrc
