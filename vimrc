"profile start ~/vim-profile.log

"set re=0

"if &compatible
"   set nocompatible     " we don't need vi compatibility, give us all of vim
"endif

set runtimepath+=~/.data/cartridges/vim

"set statusline=%F%m%r%h%w%=\ [%Y]\ [%{&ff}]\ [%04l,%04v]\ [%p%%]\ [%L]
set statusline=%F%m%r%h%w\ [%Y:%{&ff}]\ [A=\%03.3b]\ [0x=\%02.2B]\ [%l/%L,%v][%p%%]\ %{fugitive#statusline()}

set lazyredraw		" don't redraw when running macros
set ttyfast		" fast local tty

set visualbell		" stop the beeping!
set t_vb=
set noerrorbells

set history=1000	" keep some history
 
set clipboard+=unnamedplus " Uses OS clipboard (shares clipboard accross vim instances)

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

" use rg instead of grep
set grepprg=rg\ --vimgrep " ripgrep is smarter and faster
set grepformat^=%f:%l:%c:%m

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

"set nottybuiltin	" maybe not?
"
if !has('nvim')
  set ttyscroll=5
  set ttymouse=sgr	" enable mouse in terminal
end

" mouse support
set title		" setup my title
set mouse=a		" enable mouse in all modes

" Tell vim to remember certain things when we exit
" '50  :  marks will be remembered for up to 50 previously edited files
" "100 :  will save up to 100 lines for each register
" :20  :  up to 20 lines of command-line history will be remembered
" %    :  saves and restores the buffer list
" n... :  where to save the viminfo files
set viminfo='50,\"100,:20,%,n~/.viminfo

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
set path=~/src/github.com/Shopify/**

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

	" mako templates
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
	"autocmd BufNewFile,BufRead *.py compiler pytest
	"autocmd FileType python setlocal omnifunc=pysmell#Complete
	"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

	" commit messages wrap at 76 chars
	au FileType svn setlocal spell tw=76
	au FileType git setlocal spell tw=76

	" email wrap-around at 72 chars
	au BufRead /tmp/mutt-* set tw=72

	" JavaScript/TypeScript
	autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab shiftround softtabstop=2 smartindent
	autocmd FileType javascriptreact setlocal tabstop=2 shiftwidth=2 expandtab shiftround softtabstop=2 smartindent
	autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 expandtab shiftround softtabstop=2 smartindent
	autocmd FileType typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab shiftround softtabstop=2 smartindent

	au BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
	au BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

	autocmd FileType xml setlocal ts=2 sw=2 et shiftround sts=2 si
	autocmd FileType xml setlocal ts=2 sw=2 et shiftround sts=2 si
endif

" hightlight espaces at end of lines
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" This will highlight spaces before a tab:
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%81v.*/

let mapleader=','

" show trailing spaces, tabs
set list
set listchars=tab:_\ ,trail:_
" Shortcut to rapidly toggle `set list`
nmap <leader>s :set list!<CR>

" Plug
filetype off
call plug#begin('~/.vim/plugged')

" git commit editor
Plug 'rhysd/committia.vim'
" git diff status in gutter
Plug 'mhinz/vim-signify'

" inkpot theme
Plug 'ciaranm/inkpot'

" Better html handling
"Plug 'othree/html5.vim'

Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'

"Plug 'Lokaltog/vim-powerline'

" turn ANSI Color codes into syntax color
Plug 'vim-scripts/AnsiEsc.vim'

" edit one file with root privleges without running the whole session that way
Plug 'vim-scripts/sudo.vim'

" CTRL-X / to close a tag
Plug 'tpope/vim-ragtag'

" ,w into ProgrammingLanguage prog_lang progLang words
Plug 'vim-scripts/camelcasemotion'

" indent guides
Plug 'nathanaelkane/vim-indent-guides'

" github markdown
Plug 'jtratner/vim-flavored-markdown'

Plug 'junegunn/rainbow_parentheses.vim'

" Speech Recognition/Voice control. Commented out because I
" am still figuring out how to install it.
" Plug 'shippy/vim-grammar'

Plug 'rust-lang/rust.vim'

" JS / TypeScript / React
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

Plug 'prettier/vim-prettier' , {
     \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

" Snippets

"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" colorschemes
Plug 'wesgibbs/vim-irblack'
Plug 'tpope/vim-vividchalk'
Plug 'ciaranm/inkpot'

" kotlin
Plug 'udalov/kotlin-vim'

" copilot
Plug 'github/copilot.vim'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'mattn/vim-lsp-settings'

" :FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" :MRU, also provides :FZFMru
Plug 'yegappan/mru'

" :TestNearest, :TestFile, :TestSuite, :TestLast, :TestVisit
Plug 'vim-test/vim-test'

" :ChatGPT
Plug 'jackMort/ChatGPT.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
      "

call plug#end()

filetype plugin indent on

let mapleader=','

" auto formatters
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

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

" set inkpot colorscheme if 256 colors are available
if (&t_Co >= 256)
	if exists("syntax_on")
		syntax reset
 	endif
	colorscheme vividchalk
endif

set laststatus=2 " make the last line where the status is two lines deep so you can see status always

" fix for broken or slow syntax highlighting
set re=0

" Give more space for displaying messages.
set cmdheight=2

" asynccomplete.vim
set completeopt+=noinsert,menuone,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

if has('nvim')
  imap <c-space> <Plug>(asyncomplete_force_refresh)
else
  imap <c-@> <Plug>(asyncomplete_force_refresh)
end

" lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" FZF
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --max-filesize 1M'
nnoremap <leader>f :FZF<CR>

" MRU
nnoremap <leader>m :FZFMru<CR>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" ChatGPT
lua <<EOF
-- chat gpt
require("chatgpt").setup()
EOF
