set nocompatible	" we don't need vi compatibility, give us all of vim
set nomodeline		" do not parse embedded modelines (see: CVE-2007-2438)

set lazyredraw		" don't redraw when running macros
set ttyfast		" fast local tty

set visualbell		" stop the beeping!
set t_vb=
set noerrorbells

set history=1000	" keep some history

set clipboard=unnamed	" Uses OS clipboard (shares clipboard accross vim instances)
"set clipboard=*	" Uses OS clipboard (shares clipboard accross vim instances)

set backspace=indent,eol,start " backspace over autoident, EOL, and start of insert

set number		" line numbers
set hlsearch		" highlight search matches

" <esc> also turns off highlighted matches
"nnoremap <esc> <esc>:nohl<cr>
set incsearch		" incremental search (jump to partial match)

set smartcase		" if I put case variation in my search, it's cause I care
set showmatch		" show matching brackets

set scrolloff=8		" keep at least this many lines above/below cursor
set sidescrolloff=5	" keep at least this many columns left/right of cursor

" use ack instead of grep
set grepprg=ack		" ack is smarter
" this allows me to define ack as a lowercase command and it won't get
" expanded mid-word
function! CommandCabbr(abbreviation, expansion)
	execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)
" Use it on itself to define a simpler abbreviation for itself.
CommandCabbr ccab CommandCabbr
CommandCabbr ack grep

set showmode		" vim lets us know which mode we're in
set showcmd		" show partial command in last line of screen
set shortmess+=rnixnm	" shorter messages

set statusline=%F%m%r%h%w\ [%Y:%{&ff}]\ [A=\%03.3b]\ [0x=\%02.2B]\ [%l/%L,%v][%p%%]\ %{fugitive#statusline()}
set laststatus=2 " make the last line where the status is two lines deep so you can see status always

"set nottybuiltin	" maybe not?
set ttyscroll=5

" mouse support
set title		" setup my title
set ttymouse=xterm2	" enable mouse in terminal
set mouse=a		" enable mouse in all modes

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
set path=~/projects/**


" file explorer preferences
let g:netrw_list_hide = ".*\.pyc$,^darcs.*,.*patch$,_darcs,*.egg-info,\.svn,\.hg,\.git,\.swp,\.swo"
let g:netrw_noretmap = 1 " do not make double click return to netrw browser
let g:netrw_use_noswf = 1

syntax on
filetype plugin on
filetype indent on

if has("autocmd")
	" sql
	au! BufRead,BufNewFile *.sql setfiletype mysql
	au BufWinEnter *.sql setfiletype mysql
	au! BufRead,BufNewFile /tmp/sql* setfiletype mysql
	au FileType mysql set si et ts=4 sw=4

	" JavaScript
	au FileType javascript set si et ts=4 sw=4

	" mako templates
	au! BufRead,BufNewFile *.mtpl setfiletype htmlmako
	au BufWinEnter *.mtpl setfiletype htmlmako
	au! BufRead,BufNewFile *.mako setfiletype htmlmako
	au BufWinEnter *.mako setfiletype htmlmako

	" twig templates
	au! BufRead,BufNewFile *.twig setfiletype htmljinja
	au BufWinEnter *.twig setfiletype htmljinja

	" jinja templates
	au! BufRead,BufNewFile *.jinja setfiletype htmljinja
	au BufWinEnter *.jinja setfiletype htmljinja
	au! BufRead,BufNewFile *.html setfiletype htmljinja
	au BufWinEnter *.html setfiletype htmljinja
	autocmd FileType htmljinja set formatoptions+=tl
	autocmd FileType htmljinja set noai nosi et sw=4 ts=4

	" for Perl programming, have things in braces indenting themselves:
	autocmd FileType perl set smartindent

	" for CSS, also have things in braces indented:
	autocmd FileType css set smartindent

	" For PHP we use 8 tabstops and real tab characters
	autocmd FileType php set noexpandtab tabstop=8

	" in makefiles, don't expand tabs to spaces, since actual tab characters are
	" needed, and have indentation at 8 chars to be sure that all indents are tabs
	" (despite the mappings later):
	autocmd FileType make set noexpandtab shiftwidth=8

	" for Python
	autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab shiftround softtabstop=4 noautoindent foldenable smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
	autocmd BufNewFile,BufRead *.py compiler nose
	"autocmd FileType python setlocal omnifunc=pysmell#Complete
	"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

	" commit messages wrap at 76 chars
	au FileType svn setlocal spell tw=76
	au FileType git setlocal spell tw=76

	" email wrap-around at 72 chars
	au BufRead /tmp/mutt-* set tw=72
endif

" hightlight espaces at end of lines
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
" This will highlight spaces before a tab:
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

let mapleader=','

" show trailing spaces, tabs
set list
set listchars=tab:_\ ,trail:_
" Shortcut to rapidly toggle `set list`
nmap <leader>s :set list!<CR>

" bundle
filetype off
set rtp+=~/.vim/vundle.git
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Bundle "git-commit"
Bundle "inkpot"
Bundle "git@github.com:ocim/molly.vim.git"
" Better html handling
Bundle "git://github.com/othree/html5.vim.git"
Bundle "Jinja"
Bundle "git@github.com:ocim/htmljinja.vim.git"
Bundle "mako.vim"
Bundle "git@github.com:ocim/htmlmako.vim.git"
Bundle "pep8"
"Bundle "pyflakes.vim" " needs python2.6 compiled in
"let g:pyflakes_use_quickfix = 0 " no pyflakes in command window
Bundle 'python.vim--Vasiliev'
Bundle "git://github.com/tsaleh/vim-matchit.git"
Bundle "git://github.com/reinh/vim-makegreen.git"
Bundle "git://github.com/olethanh/Vim-nosecompiler.git"
Bundle "git://github.com/tpope/vim-fugitive.git"
Bundle "git://github.com/kien/ctrlp.vim.git"

" powerline requires a more modern vim than CentOS provides
"Bundle "git://github.com/Lokaltog/vim-powerline.git"

" turn ANSI Color codes into syntax color
Bundle "git://github.com/vim-scripts/AnsiEsc.vim.git"

" edit one file with root privleges without running the whole session that way
Bundle "git://github.com/vim-scripts/sudo.vim.git"

" CTRL-X / to close a tag
Bundle "git://github.com/tpope/vim-ragtag.git"

" ,w into ProgrammingLanguage prog_lang progLang words
Bundle "git://github.com/vim-scripts/camelcasemotion.git"

" on the fly syntax checking
Bundle "git://github.com/scrooloose/syntastic.git"

" indent guides
Bundle "git://github.com/nathanaelkane/vim-indent-guides.git"

" github markdown
Bundle "git://github.com/jtratner/vim-flavored-markdown.git"

" gitv - gitk clone, repo viewer
Bundle "git://github.com/gregsexton/gitv.git"

call vundle#end()            " required
filetype plugin indent on    " required



let mapleader=','
" Command-T
nmap <leader>t :tabnew<cr>:Molly<cr>
map B <down>
map A <up>

" tab helpers
nmap <leader>[ :tabprev<CR>
nmap <leader>] :tabnext<CR>
nmap <leader>T :tabnew<CR>

" buffer helpers
nmap <leader>h :prev<cr>
nmap <leader>l :next<cr>
nmap <leader>b :buffers<cr>

" cwindow settings and helpers
cwindow 30	" size of error window
nmap <leader>c :cwindow<cr>
nmap <leader>k :cprev<cr>
nmap <leader>j :cnext<cr>

" grep/ack helpers
nmap <leader>G :grep! <cword><cr>:cwindow<cr>
nmap <leader>g :grepadd! <cword><cr>:cwindow<cr>

" unittests
nmap <leader>m :call MakeGreen()<cr>

" set inkpot colorscheme if 256 colors are available
if (&t_Co >= 256)
	if exists("syntax_on")
		syntax reset
	endif
	colorscheme inkpot
endif
