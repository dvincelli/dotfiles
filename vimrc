set nocompatible	" we don't need vi compatibility, give us all of vim
set nomodeline		" do not parse embedded modelines (see: CVE-2007-2438)


set lazyredraw		" don't redraw when running macros
set ttyfast		" fast local tty

set novisualbell	" no visual bell
set noeb		" no error bell *only slightly more annoying than visual bells*

set history=100		" keep some history

set clipboard=unnamed	" Uses OS clipboard (shares clipboard accross vim instances)

set noeol		" Don't automatically insert EOL at EOF

set backspace=indent,eol,start " backspace over autoident, EOL, and start of insert

set number		" line numbers

set hlsearch		" highlight search matches
set incsearch		" incremental search (jump to partial match)

set smartcase		" if I put case variation in my search, it's cause I care
set showmatch		" show matching brackets

set scrolloff=8		" keep at least this many lines above/below cursor
set sidescrolloff=5	" keep at least this many columns left/right of cursor

set grepprg=ack		" ack is smarter

set showmode		" vim lets us know which mode we're in
set showcmd		" show partial command in last line of screen
set shortmess+=rnixnm	" shorter messages

set statusline=%F%m%r%h%w\ [%Y:%{&ff}]\ [A=\%03.3b]\ [0x=\%02.2B]\ [%l/%L,%v][%p%%]\ %{$PYTHONPROJECT}
set laststatus=2 " make the last line where the status is two lines deep so you can see status always

set ttymouse=xterm2	" enable mouse in terminal
set mouse=a		" enable mouse in all modes

set wildmenu		" enable wildmenu
set wildmode=list:longest,full	" match order
set wildchar=<tab>	" complete on tab
set wildignore+=.git,*.pyc,*.egg,data/*,build/*,dist/*,*.egg-info/*,data/* " these aren't good

" change default auto-complete menu colors
highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30

" do not complete on these
set suffixes+=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.cmi,.cmo,.swo,.pyc,TAGS,PYSMELLTAGS

"set nofoldenable
"set foldmethod=marker

set path=~/projects/**


cwindow 30		" size of error window

let g:netrw_list_hide = ".*\.pyc$,^darcs.*,.*patch$,_darcs,*.egg-info,\.svn,\.hg,\.git,\.swp,\.swo"
let g:netrw_noretmap = 1 " do not make double click return to netrw browser
let g:netrw_use_noswf = 1

syntax on
filetype plugin indent on

if has("autocmd")
	" mako templates
	au! BufRead,BufNewFile *.mtpl setfiletype mako
	au BufWinEnter *.mtpl setfiletype mako
	au! BufRead,BufNewFile *.mako setfiletype mako
	au BufWinEnter *.mako setfiletype mako

	" twig templates
	" au! BufRead,BufNewFile *.twig setfiletype htmltwig
	" au BufWinEnter *.twig setfiletype htmltwig
	au! BufRead,BufNewFile *.twig setfiletype jinja
	au BufWinEnter *.twig setfiletype jinja

	" for Perl programming, have things in braces indenting themselves:
	autocmd FileType perl set smartindent

	" for CSS, also have things in braces indented:
	autocmd FileType css set smartindent

	" for HTML, generally format text, but if a long line has been created leave it
	" alone when editing:
	autocmd FileType html set formatoptions+=tl

	" for both CSS and HTML, use genuine tab characters for indentation, to make
	" files a few bytes smaller:
	autocmd FileType html,css set noexpandtab tabstop=2

	" For PHP we use 8 tabstops and real tab characters
	autocmd FileType php set noexpandtab tabstop=8

	" in makefiles, don't expand tabs to spaces, since actual tab characters are
	" needed, and have indentation at 8 chars to be sure that all indents are tabs
	" (despite the mappings later):
	autocmd FileType make set noexpandtab shiftwidth=8

	" for Python
	autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab shiftround softtabstop=4 noautoindent foldenable smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
	"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
 	autocmd BufNewFile,BufRead *.py compiler nose
	"autocmd FileType python setlocal omnifunc=pysmell#Complete

	au FileType svn setlocal spell tw=76
	au FileType git setlocal spell tw=76

	au BufRead /tmp/mutt-* set tw=72
endif

" hightlight spaces at end of lines
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
" This will highlight spaces before a tab:
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:·
set list


" common typos
iab susbcriber subscriber
iab susbcription subscription
iab susbcribe subscribe

" bundles
set rtp+=~/.vim/vundle.git
call vundle#rc()

"Bundle "Align.vim"	" needed for SQLUtilities
"Bundle "SQLUtilities"	
Bundle "CSApprox"
Bundle "git-commit"
Bundle "inkpot"
Bundle "Jinja"
Bundle "mako.vim"
Bundle "molly.vim"
Bundle "pep8"
Bundle "pyflakes.vim"
Bundle 'python.vim--Vasiliev'
Bundle "git://github.com/reinh/vim-makegreen.git"
Bundle "git://github.com/olethanh/Vim-nosecompiler.git"


" Command-T
nmap <leader>t :Molly<CR>
map OB <down>
map OA <up>

" unittests
map <Leader>m :call MakeGreen()<cr>

if (&t_Co >= 256)	" if we have colors
	if exists("syntax_on")
		syntax reset
	endif
	colorscheme inkpot
endif

let g:pyflakes_use_quickfix = 0 " no pyflakes in command window
let mapleader=','
