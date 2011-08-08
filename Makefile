
all: install-bin install-bash install-git install-screen install-mysql install-vim

install-bash:	install-vcprompt
	cp bashrc ~/.bashrc
	cp bashrc.colors ~/.bashrc.colors

install-git:
	NAME=$(git config --global user.name) \
	EMAIL=$(git config --global user.email) \
	[ -e ~/.gitconfig ] && cp ~/.gitconfig ~/.gitconfig.bak && \
	cp gitconfig ~/.gitconfig && \
	git config --global user.name="${NAME}" && \
	git config --global user.email="${EMAIL}"

install-screen:
	cp screenrc ~/.screenrc

install-mysql:
	cp my.cnf ~/.my.cnf

install-vcprompt:
	#mkdir -p vcprompt
	#test -e vcprompt/Makefile || curl -s http://vc.gerg.ca/hg/vcprompt/archive/tip.tar.gz | tar zxp --strip-components 1 - -C vcprompt
	#cd vcprompt && make install # needs root
	echo "Please install vcprompt manually"

install-vim:
	cp vimrc ~/.vimrc
	cp gvimrc ~/.gvimrc
	mkdir -p ~/.vim/plugin
	[ -e ~/.vim/vundle.git ] || git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git

install-ack:
	test -e ~/bin/ack || curl -s http://betterthangrep.com/ack-standalone > ~/bin/ack && chmod 0755 ~/bin/ack
	cp ackrc ~/.ackrc

install-bin: install-ack


