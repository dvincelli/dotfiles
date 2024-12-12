if [[ -r /etc/zsh/zshrc.default.inc.zsh ]]; then
  source /etc/zsh/zshrc.default.inc.zsh
fi

fpath=($HOME/.zsh-completions $fpath)

zstyle ':completion:*' use-cache on
autoload -U compinit; compinit

[ -f /opt/dev/sh/chruby/chruby.sh ] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[ -x /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)

if [[ -d $HOME/.pyenv ]]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
fi

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line
bindkey '^X^e' edit-command-line

for file in ~/.zshrc.d/*; do
  source $file
done
