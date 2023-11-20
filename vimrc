set re=0

if &compatible
  set nocompatible	" we don't need vi compatibility, give us all of vim
endif

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

" use rg instead of grep
set grepprg=rg\	--vimgrep " ripgrep is smarter and faster
set grepformat^=%f:%l:%c:%m

set showmode		" vim lets us know which mode we're in
set showcmd		" show partial command in last line of screen
set shortmess+=rnixnm	" shorter messages

set statusline=%F%m%r%h%w\ [%Y:%{&ff}]\ [A=\%03.3b]\ [0x=\%02.2B]\ [%l/%L,%v][%p%%]\ %{fugitive#statusline()}
set laststatus=2 " make the last line where the status is two lines deep so you can see status always

"set nottybuiltin	" maybe not?

set title		" setup my title

if ! has('nvim')
	set ttyscroll=5
	set ttymouse=xterm2	" enable mouse in terminal
endif

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
set path=~/src/github.com/**

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

	" jinja templates
	au! BufRead,BufNewFile *.j2 setfiletype htmljinja
	au! BufRead,BufNewFile *.jinja setfiletype htmljinja
	au BufWinEnter *.jinja setfiletype htmljinja
	au! BufRead,BufNewFile *.html setfiletype htmljinja
	au BufWinEnter *.html setfiletype htmljinja
	autocmd FileType htmljinja set formatoptions+=tl
	autocmd FileType htmljinja set noai nosi et sw=4 ts=4

	" for CSS, also have things in braces indented:
	autocmd FileType css set smartindent

	" in makefiles, don't expand tabs to spaces, since actual tab characters are
	" needed, and have indentation at 8 chars to be sure that all indents are tabs
	" (despite the mappings later):
	autocmd FileType make set noexpandtab shiftwidth=8

	" for Python
	autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab shiftround softtabstop=4 noautoindent foldenable smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
	"autocmd BufNewFile,BufRead *.py compiler pytest
	"autocmd FileType python setlocal omnifunc=pysmell#Complete
	"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	
	" for Shell
	autocmd FileType sh setlocal ts=4 sw=4 et softtabstop=4 smartindent

	" commit messages wrap at 76 chars
	au FileType git setlocal spell tw=76

	" JavaScript/TypeScript
	autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab shiftround softtabstop=2 smartindent
	autocmd FileType javascriptreact setlocal tabstop=2 shiftwidth=2 expandtab shiftround softtabstop=2 smartindent
	autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 expandtab shiftround softtabstop=2 smartindent
	autocmd FileType typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab shiftround softtabstop=2 smartindent

	au BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
	au BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
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
Plug 'kien/ctrlp.vim'

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


" js/ts plugins
" on the fly syntax checking. Replaced by LSP (below)
"Plug 'scrooloose/syntastic'
"let g:syntastic_python_checkers=['flake8', 'mypy']

" pyright, lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-pyright',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-go',
  \ 'coc-solargraph',
  \ 'coc-markdownlint',
  \ 'coc-rust-analyzer',
  \ 'coc-sh'
  \ ]

" JS / TypeScript / React
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

" Snippets

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


call plug#end()
filetype plugin indent on

let mapleader=','

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

" grep/rg helpers
nmap <leader>G :grep! <cword><cr>:cwindow<cr>
nmap <leader>g :grepadd! <cword><cr>:cwindow<cr>

" unittests
"nmap <leader>m :call MakeGreen()<cr>


" set inkpot colorscheme if 256 colors are available
if (&t_Co >= 256)
	if exists("syntax_on")
		syntax reset
	endif
	colorscheme inkpot
endif

" coc.nvim required config

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
set statusline=%F%m%r%h%w\ [%Y:%{&ff}]\ [A=\%03.3b]\ [0x=\%02.2B]\ [%l/%L,%v][%p%%]\ %{fugitive#statusline()}\ %{coc#status()}

set laststatus=2 " make the last line where the status is two lines deep so you can see status always
