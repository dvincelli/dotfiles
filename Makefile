all: bashrc bin screenrc tmux mysql vimrc gitprompt agignore

bin:
	mkdir -p ~/bin

rgignore:
	ln -sf $(PWD)/rgignore ~/.rgignore

bashrc:
	ln -sf $(PWD)/bashrc ~/.bashrc
	ln -sf $(PWD)/bashrc.colors ~/.bashrc.colors
	ln -sf $(PWD)/bashrc.k8s ~/.bashrc.k8s

screenrc:
	ln -sf $(PWD)/screenrc ~/.screenrc

tmux:
	ln -sf $(PWD)/tmux.conf ~/.tmux.conf

mysql:
	ln -sf $(PWD)/my.cnf ~/.my.cnf

vimrc:
	ln -sf $(PWD)/vimrc ~/.vimrc
	ln -sf $(PWD)/gvimrc ~/.gvimrc
	mkdir -p ~/.vim/plugin
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

gitprompt:
	curl -L -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh

nvm:
	export NVM_DIR="$(HOME)/.nvm" && (   git clone https://github.com/nvm-sh/nvm.git "$(NVM_DIR)";   cd "$(NVM_DIR)";   git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`; ) && \. "$(NVM_DIR)/nvm.sh"

clip:
	ln -s clip ~/bin/clip

.PHONY: all ackrc bashrc bin screenrc tmux mysql vimrc rgignore clip nvm
