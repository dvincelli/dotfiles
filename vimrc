" Enable for debugging...
"profile start ~/vim-profile.log

" Prefer utf-8, respect bom encodings
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set fileencoding=utf-8

scriptencoding utf-8 " this script is utf-8

set nocompatible     " we don't need vi compatibility, give us all of vim

set statusline=%F%m%r%h%w%=\ [%Y]\ [%{&ff}]\ [%04l,%04v]\ [%p%%]\ [%L]
"set statusline=%F%m%r%h%w\ [%Y:%{&ff}]\ [A=\%03.3b]\ [0x=\%02.2B]\ [%l/%L,%v][%p%%]\ %{fugitive#statusline()}
set laststatus=2 " make the last line where the status is two lines deep so you can see status always
"set cmdheight=2

set lazyredraw		" don't redraw when running macros
set ttyfast		" fast local tty

set visualbell		" stop the beeping!
set t_vb=
set noerrorbells

set history=1000	" keep some history
 
set guioptions=a
set clipboard=unnamed,unnamedplus " Uses OS clipboard (shares clipboard accross vim instances)

set backspace=indent,eol,start " backspace over autoident, EOL, and start of insert

set number		" line numbers
set hlsearch		" highlight search matches

" <esc> also turns off highlighted matches
nnoremap <esc> <esc>:nohl<cr>
set incsearch		" incremental search (jump to partial match)

set smartcase		" if I put case variation in my search, it's cause I care
set showmatch		" show matching brackets

set scrolloff=5		" keep at least this many lines above/below cursor
set sidescrolloff=5	" keep at least this many columns left/right of cursor

" use rg instead of grep
set grepprg=rg\ --vimgrep " ripgrep is smarter and faster
set grepformat^=%f:%l:%c:%m

let mapleader=','
let g:mapleader = ","
let g:maplocalleader = ","

" this allows me to define rg as a lowercase command and it won't get
" expanded mid-word
function! CommandCabbr(abbreviation, expansion)
	execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)
" Use it on itself to define a simpler abbreviation for itself.
CommandCabbr ccab CommandCabbr
CommandCabbr rg grep

set showmode		" vim lets us know which mode we're in
set showcmd		" show partial command in last line of screen
set shortmess+=rnixnm	" shorter messages

"set nottybuiltin	" skips internal termcap, uses only system termcap

" mouse support
set title		" setup my title
set mouse=a		" enable mouse in all modes
set ttymouse=xterm2	" scroll, select

" Tell vim to remember certain things when we exit
" '50  :  marks will be remembered for up to 50 previously edited files
" "100 :  will save up to 100 lines for each register
" :1000  :  up to 1000 lines of command-line history will be remembered
" %    :  saves and restores the buffer list
" n... :  where to save the viminfo files
"
set viminfo='50,\"100,:1000,%,n~/.viminfo

" completion
set wildmenu		" enable wildmenu
set wildmode=list:longest,full	" match order
set wildchar=<tab>	" complete on tab
set wildignore+=.git,*.pyc,*.egg,./data/**,./build/**,./dist/**,./*.egg-info/**,./*.egg/,data/*,build/*,dist/*,*.egg-info,*.egg/**

" change default auto-complete menu colors
highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30

" do not complete on these
set suffixes+=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.cmi,.cmo,.swo,.pyc,TAGS

" personal project hierarchy
set path=~/src/**

" file explorer preferences
let g:netrw_list_hide = ".*\.pyc$,^darcs.*,.*patch$,_darcs,*.egg-info,\.svn,\.hg,\.git,\.swp,\.swo,_build"
let g:netrw_noretmap = 1 " do not make double click return to netrw browser
let g:netrw_use_noswf = 1

syntax on
filetype plugin on
filetype indent on

" hightlight espaces at end of lines
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" This will highlight spaces before a tab:
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%81v.*/

" show trailing spaces, tabs
set list
set listchars=tab:\ \ ,trail:\ ,nbsp:\ 
"test:	   	 ....    
" Shortcut to rapidly toggle `set list`
nmap <leader><esc> :set list!<CR>

" grep helpers
nmap <leader>s :grep! <cword><cr>:cwindow<cr>
nmap <leader>S :grepadd! <cword><cr>:cwindow<cr>

if has('termguicolors')
    set termguicolors
endif

" set colorscheme if 256 colors are available
if (&t_Co >= 256)
  if exists("syntax_on")
    syntax reset
  endif
  let v:errmsg = ''
  silent! colorscheme darkblue
  " If not installed, display warning message
  if v:errmsg != ''
    echohl WarningMsg
    echom "colorscheme not found. Please install the plugin or change the colorscheme."
    echohl None
  endif
endif

highlight SpecialKey ctermfg=NONE ctermbg=236 guifg=NONE guibg=#21222C
highlight NonText    ctermbg=236 guibg=#21222C

" fix for broken or slow syntax highlighting
set re=0

set completeopt+=noinsert,menuone,noselect

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

" vim-test
set timeoutlen=500
set timeout

" Conditional include of ~/.vimrc.local
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local	
endif

if has("autocmd")
  " mako templates
  au BufWinEnter *.mtpl setfiletype htmlmako
  au! BufRead,BufNewFile *.mako setfiletype htmlmako
  au BufWinEnter *.mako setfiletype htmlmako

  " twig templates
  au! BufRead,BufNewFile *.twig setfiletype htmldjango
  au BufWinEnter *.twig setfiletype htmldjango

  " jinja templates
  au! BufRead,BufNewFile *.jinja setfiletype htmldjango
  au! BufRead,BufNewFile *.j2 setfiletype htmldjango
  au! BufRead,BufNewFile *.jinja2 setfiletype htmldjango
  au BufWinEnter *.jinja setfiletype htmldjango
  au BufWinEnter *.j2 setfiletype htmldjango
  au BufWinEnter *.jinja2 setfiletype htmldjango
  autocmd FileType htmldjango set formatoptions+=tl
  autocmd FileType htmldjango set noai nosi et sw=4 ts=4

  " for CSS, also have things in braces indented:
  autocmd FileType css set smartindent

  augroup python
    autocmd!
    autocmd FileType python setlocal
        \ et shiftwidth=4 tabstop=4
        \ commentstring="#\ %s"
        \ foldmethod=indent
   augroup END

  augroup haskell
    autocmd!
    autocmd FileType haskell setlocal
        \ noet shiftwidth=4 tabstop=4
        \ commentstring="--\ %s"
        \ foldmethod=syntax
  augroup END
  
  augroup ocaml
    autocmd!
    autocmd FileType ocaml setlocal
        \ noet shiftwidth=4 tabstop=4
        \ commentstring="(*\ %s\ *)"
        \ foldmethod=syntax
  augroup END

  " autoreload vimrc edits
  augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  augroup END
endif
