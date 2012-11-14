all: ackrc bashrc bin screenrc tmux mysql vimrc

bin:
	mkdir -p ~/bin

ackrc: bin
	[ -e ~/bin/ack ] || curl -s http://betterthangrep.com/ack-standalone > ~/bin/ack && chmod 0755 ~/bin/ack
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
	[ -e ~/.vim/vundle.git ] || git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git

.PHONY: all ackrc bashrc bin screenrc tmux mysql vimrc
