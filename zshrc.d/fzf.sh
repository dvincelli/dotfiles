export FZF_DEFAULT_COMMAND='rg -l ""'
export FZF_DEFAULT_OPTS='
--color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
--color info:183,prompt:110,spinner:107,pointer:167,marker:215
'


cf() {
    find . -type d | fzf | xargs cd
}

vf() {
    find . -type f | fzf | xargs nvim
}
