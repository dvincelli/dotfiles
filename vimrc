" This vimrc is intended to run on a stock reasonably modern version of plain
" VIM like Vim classic, vim 8.x or vim 9.x - it depends on no plugins
" intentionally, it also expects a modern version of XTerm with truecolor and
" mouse support. It is intentionally avoiding languageservers for the time
" being.

" Enable for debugging...
"profile start ~/vim-profile.log

" Prefer utf-8, respect bom encodings
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set fileencoding=utf-8

scriptencoding utf-8 " this script is utf-8

set nocompatible     " we don't need vi compatibility, give us all of vim

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
"highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30

" do not complete on these
set suffixes+=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.cmi,.cmo,.swo,.pyc,TAGS

" personal project hierarchy
set path=~/src/**

" file explorer preferences
let g:netrw_list_hide = ".*\.pyc$,^darcs.*,.*patch$,_darcs,*.egg-info,\.svn,\.hg,\.git,\.swp,\.swo,_build"
let g:netrw_noretmap = 1 " do not make double click return to netrw browser
let g:netrw_use_noswf = 1
let g:netrw_keepdir = 0    " ensures actions happens in dir
let g:netrw_liststyle = 3  " tree view instead of flat list
let g:netrw_banner = 0     " no giant banner
nnoremap - :Explore<CR>

" Safe recursive delete with a confirmation prompt
function! NetrwSafeDelete()
    let l:item = expand('<cfile>')
    if empty(l:item) || l:item ==# './' || l:item ==# '../'
        return
    endif

    let l:path = b:netrw_curdir . '/' . l:item

    if isdirectory(l:path)
        if confirm("Recursively delete directory '" . l:item . "'?", "&Yes\n&No", 2) == 1
            call system('rm -rf ' . shellescape(l:path))
            execute "normal \<C-l>"
        endif
    else
        call delete(l:path)
        execute "normal \<C-l>"
    endif
endfunction



augroup NetrwCustom
    autocmd!
    " Persistent cheat sheet in the statusline (only when inside netrw)
    autocmd FileType netrw setlocal statusline=\ [%%]\ New\ File\ \ [d]\ New\ Dir\ \ [R]\ Rename\ \ [D]\ Delete\ \ [mf]\ Mark\ \ [-]\ Up\ %=\ %{b:netrw_curdir}\
    " Override 'D' with smart single-file / prompted-directory delete
    autocmd FileType netrw nnoremap <buffer> <silent> D :call NetrwSafeDelete()<CR>
augroup END


syntax on
filetype plugin on
filetype indent on

 if has('termguicolors')
    set termguicolors
  endif
" set colorscheme if 256 colors are available
if (&t_Co >= 256)

  "if exists("syntax_on")
  "  syntax reset
  "endif
  let v:errmsg = ''
  silent! colorscheme darkblue
  " If not installed, display warning message
  if v:errmsg != ''
    echohl WarningMsg
    echom "colorscheme not found. Please install the plugin or change the colorscheme."
    echohl None
  endif
endif

" This belongs after the colorscheme is set
highlight SpecialKey ctermfg=NONE ctermbg=236 guifg=NONE guibg=#21222C
highlight NonText    ctermbg=236 guibg=#21222C
"test:	   	 ....    test 1,2,3   

" hightlight espaces at end of lines
highlight OverLength ctermbg=darkred guibg=darkred
match OverLength /\%81v.*/

" hightlight espaces at end of lines
highlight WhitespaceEOL ctermbg=darkred guibg=darkred
match WhitespaceEOL /\s\+$/

" This will highlight spaces before a tab:
highlight RedundantSpaces ctermbg=darkred guibg=darkred
match RedundantSpaces /\s\+$\| \+\ze\t/

" show trailing spaces, tabs
set list
set listchars=tab:\ \ ,trail:\ ,nbsp:\ 
"test:	   	 ....    test 1,2,3

" Shortcut to rapidly toggle `set list`
nmap <leader><esc> :set list!<CR>

" grep helpers
nmap <leader>s :grep! <cword><cr>:cwindow<cr>
nmap <leader>S :grepadd! <cword><cr>:cwindow<cr>

" fix for broken or slow syntax highlighting
set re=0

" completion
set completeopt=menuone,noinsert,noselect

function! SmartTab()
    if pumvisible()
        return "\<C-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    endif
    " Use omni-completion if the filetype supports it, otherwise keyword completion
    if &omnifunc != ''
        return "\<C-x>\<C-o>"
    else
        return "\<C-n>"
    endif
endfunction

inoremap <expr> <Tab> SmartTab()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" vim-test
set timeoutlen=500
set timeout

" git status
" --- no-plugin git statusline (fast + fail-safe) ---
if executable('git')
  " Run git in the buffer's own directory without changing Vim's cwd.
  function! s:GitUpdate()
    let b:git_branch = ''
    let b:git_dirty  = 0
    let l:dir = expand('%:p:h:S')
    let l:out = system('git -C ' . l:dir . ' branch --show-current 2>/dev/null')
    if v:shell_error == 0
      let b:git_branch = trim(l:out)
    endif
    let l:out = system('git -C ' . l:dir . ' status --porcelain 2>/dev/null')
    if v:shell_error == 0
      let b:git_dirty = (l:out !=# '')
    endif
  endfunction

 function! GitStatusline()
    if !exists('b:git_branch') | call s:GitUpdate() | endif
    if b:git_branch ==# '' | return '' | endif
    return ' [⎇ ' . b:git_branch . (b:git_dirty ? ' ✗' : ' ✓') . ']'
  endfunction

  " Refresh only on events that actually change the state.
  augroup GitStatusline
    au!
    au BufEnter,BufWritePost,FocusGained,ShellCmdPost * call s:GitUpdate()
  augroup END
else
 function! GitStatusline()
    return ''
  endfunction
endif

" %F Full path to the file in the buffer ~/src
" %f relative path to the file in the buffer
" %m modified flag: [+]
" %r readonly flag: [RO]
" %h help buffer flag: [help]
" %w Preview window flag: [preview]
" = seperation point between left and right aligned items
" %Y Type of file in the buffer
" %{&ff} line ending style
" %l,%v line, columne
" %p percentage through file in lines as in CTRL_G
" %L Number of lines in the buffer
set statusline=%F%m%r%h%w%{GitStatusline()}%=\ [%Y]\ [%{&ff}]\ [%04l,%04v]\ [%p%%]\ [%L]

if has("autocmd")

  augroup templates
    autocmd!
    autocmd BufRead,BufNewFile *.mtpl,*.mako  setfiletype html
    autocmd BufRead,BufNewFile *.twig         setfiletype htmldjango
    autocmd BufRead,BufNewFile *.jinja,*.j2,*.jinja2 setfiletype htmldjango
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

  augroup javascript
    autocmd!
    autocmd FileType javascript,typescript setlocal
        \ et shiftwidth=2 tabstop=2
        \ commentstring="//\ %s"
        \ foldmethod=syntax
  augroup END

  augroup rust
    autocmd!
    autocmd FileType rust setlocal
        \ et shiftwidth=4 tabstop=4
        \ commentstring="//\ %s"
        \ foldmethod=syntax
  augroup END

  augroup c
    autocmd!
    autocmd FileType c setlocal
        \ et shiftwidth=4 tabstop=4
        \ commentstring="/*\ %s\ */"
        \ foldmethod=syntax
  augroup END

  " autoreload vimrc edits
  augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  augroup END
endif

" Conditional include of ~/.vimrc.local
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
