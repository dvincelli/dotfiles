UNAME=$(shell uname)

all: bashrc screenrc tmux mysql nvim gitprompt agignore rgignore gitconfig pb packages

rgignore:
	ln -sf $(PWD)/rgignore ~/.rgignore

bashrc:
	ln -sf $(PWD)/bashrc ~/.bashrc
	ln -sf $(PWD)/bashrc.colors ~/.bashrc.colors
	ln -sf $(PWD)/bashrc.k8s ~/.bashrc.k8s

gitconfig:
	ln -sf $(PWD)/gitconfig ~/.gitconfig.local

screenrc:
	ln -sf $(PWD)/screenrc ~/.screenrc

tmux:
	ln -sf $(PWD)/tmux.conf ~/.tmux.conf

mysql:
	ln -sf $(PWD)/my.cnf ~/.my.cnf

nvim:
	mkdir -p ~/.config/nvim
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -sf $(PWD)/nvim/init.lua ~/.config/nvim/init.lua

gitprompt:
	curl -L -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh

nvm:
	export NVM_DIR="$(HOME)/.nvm" && (   git clone https://github.com/nvm-sh/nvm.git "$(NVM_DIR)";   cd "$(NVM_DIR)";   git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`; ) && \. "$(NVM_DIR)/nvm.sh"

pb:
	mkdir -p ~/bin
	ln -s $(PWD)/pb ~/bin/pb

packages:
ifeq ($(UNAME),Linux)
	sudo snap install yq
	yq -r '.snap[]' < packages.yaml | xargs -L1 sudo snap install
	yq -r '.apt[]' < packages.yaml | xargs -L1 sudo apt install -y --no-install-recommends
endif
ifeq ($(UNAME),Darwin)
	yq -r '.brew[]' < packages.yaml | xargs -L1 brew install
endif

.PHONY: all ackrc bashrc bin screenrc tmux mysql nvim rgignore nvm gitconfig pb packages gitprompt
