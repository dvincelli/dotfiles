set guioptions-=T	" no toolbar
set anti
set nomh		" don't hide the mouse

set numberwidth=5       " By default can fit at least 9999 lines
set lines=85
set columns=160

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  macmenu &File.Open\ Tab\.\.\. key=<nop>
  map <D-t> :CommandT<CR>
  map <D-T> :tabnew<CR>:CommandT<CR>
  colorscheme inkpot
  set gfn=Menlo\ Regular:h13	" guifont
endif

