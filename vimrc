" Enable for debugging...
"profile start ~/vim-profile.log

set nocompatible     " we don't need vi compatibility, give us all of vim

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
nnoremap <esc> <esc>:nohl<cr>
set incsearch		" incremental search (jump to partial match)

set smartcase		" if I put case variation in my search, it's cause I care
set showmatch		" show matching brackets

set scrolloff=8		" keep at least this many lines above/below cursor
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
" :500  :  up to 500 lines of command-line history will be remembered
" %    :  saves and restores the buffer list
" n... :  where to save the viminfo files
set viminfo='50,\"100,:500,%,n~/.viminfo

"" completion
"set wildmenu		" enable wildmenu
"set wildmode=list:longest,full	" match order
"set wildchar=<tab>	" complete on tab
"set wildignore+=.git,*.pyc,*.egg,./data/**,./build/**,./dist/**,./*.egg-info/**,./*.egg/,data/*,build/*,dist/*,*.egg-info,*.egg/**
"
"" change default auto-complete menu colors
"highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30

" do not complete on these
set suffixes+=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.cmi,.cmo,.swo,.pyc,TAGS

" personal project hierarchy
set path=~/src/**

" file explorer preferences
let g:netrw_list_hide = ".*\.pyc$,^darcs.*,.*patch$,_darcs,*.egg-info,\.svn,\.hg,\.git,\.swp,\.swo"
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
set listchars=tab:_\ ,trail:_
" Shortcut to rapidly toggle `set list`
nmap <leader><esc> :set list!<CR>
    ,   

" Plug
filetype off
call plug#begin('~/.vim/plugged')

" git commit editor
Plug 'rhysd/committia.vim'
" git diff status in gutter
Plug 'mhinz/vim-signify'

" Better html handling
"Plug 'othree/html5.vim'

" we have <leader>f for fzf now, disable ctrl-p
"Plug 'ctrlpvim/ctrlp.vim'

"Plug 'Lokaltog/vim-powerline'

" turn ANSI Color codes into syntax color
Plug 'vim-scripts/AnsiEsc.vim'

" edit one file with root privleges without running the whole session that way
Plug 'vim-scripts/sudo.vim'


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

" colorschemes / themes
Plug 'wesgibbs/vim-irblack'
Plug 'tpope/vim-vividchalk'
Plug 'ciaranm/inkpot'
Plug 'altercation/vim-colors-solarized'
Plug 'folke/tokyonight.nvim'
Plug 'sainnhe/sonokai'

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

" :WhichKey
Plug  'folke/which-key.nvim'

Plug 'nvim-tree/nvim-web-devicons'

" fix . repeat on map'd commands
Plug 'tpope/vim-repeat'
" fix CTRL-A/CTRL-X on dates
Plug 'tpope/vim-speeddating'
" gcc to comment out a line (and gc to comment out the target of a motion)
Plug 'tpope/vim-commentary'
" snake_case to camelCase and back
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rsi'
" CTRL-X / to close a tag
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
" modern take on dbext
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dadbod-completion'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

call plug#end()

filetype plugin indent on

" auto formatters
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" grep helpers
nmap <leader>s :grep! <cword><cr>:cwindow<cr>
nmap <leader>S :grepadd! <cword><cr>:cwindow<cr>

" set colorscheme if 256 colors are available
if (&t_Co >= 256)
	if exists("syntax_on")
		syntax reset
	endif
	colorscheme sonokai
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
    nmap <buffer> rn <plug>(lsp-rename)
    nmap <buffer> gj <plug>(lsp-previous-diagnostic)
    nmap <buffer> gk <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

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

" vim-test
set timeoutlen=500
set timeout

" ChatGPT, WhicKey
lua <<EOF
-- chat gpt
require("chatgpt").setup()

local wk = require("which-key")
wk.setup(
)

wk.register({
  c = {
    name = "ChatGPT",
      c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
      e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
      g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
      t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
      k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
      d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
      a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
      o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
      s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
      f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
      x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
      r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
      l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
    },
  l = {
    name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
      d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format code" },
      h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover information" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
      r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find references" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to type definition" },
      R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" },
      s = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document symbols" },
    -- S = { "<cmd>lua vim.lsp.buf.workspace_symbol_search()<CR>", "Workspace symbol search" },
    -- nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    -- nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    },
 t = {
    name = "Test",
      t = { "<cmd>TestNearest<CR>", "Test Nearest" },
      f = { "<cmd>TestFile<CR>", "Test File" },
      s = { "<cmd>TestSuite<CR>", "Test Suite" },
      l = { "<cmd>TestLast<CR>", "Test Last" },
      g = { "<cmd>TestVisit<CR>", "Test Visit" },
    },
  g = {
    name = "Git",
      d = { "<cmd>Gdiffsplit<CR>", "Git Diff" },
      b = { "<cmd>Git blame<CR>", "Git Blame" },
      c = { "<cmd>Git commit<CR>", "Git Commit" },
      p = { "<cmd>Git push --force-with-lease --force-if-includes<CR>", "Git Push" },
      P = { "<cmd>Git pull<CR>", "Git Pull" },
      s = { "<cmd>Git status<CR>", "Git Status" },
      r = {" <cmd>Git rebase -i origin/main<CR>", "Git rebase" }, -- will this work?
      l = { "<cmd>Git log<CR>", "Git Log" },
      h = { "<cmd>Git hist<CR>", "Git history" },
      t = { "<cmd>Git stash<CR>", "Git Stash" },
      T = { "<cmd>Git stash pop<CR>", "Git Stash Pop" },
      f = { "<cmd>Git fetch<CR>", "Git Fetch" },
      F = { "<cmd>Git fetch --all<CR>", "Git Fetch All" },
      A = { "<cmd>Git add -A<CR>", "Git Add All" },
      C = { "<cmd>Git checkout", "Git Checkout" },
    },
  -- fzf
  f = { "<cmd>FZF<CR>", "Fuzzy Open File" },
  m = { "<cmd>FZFMru<CR>", "Fuzzy Open MRU" },
  -- buffers
  b = {
    name = "Buffers",
     ["]"] = { "<cmd>bn<CR>", "Next Buffer" },
     ["["] = { "<cmd>bp<CR>", "Previous Buffer" },
     ["d"] = { "<cmd>bd<CR>", "Delete Buffer" },
     ["D"] = { "<cmd>bufdo bd<CR>", "Delete All Buffers" },
     ["l"] = { "<cmd>ls<CR>", "List Buffers" },
  },
  -- tabs
  t = {
    name = "Tabs",
    ["["] = { "<cmd>tabprev<CR>", "Previous Tab" },
    ["]"] = { "<cmd>tabnext<CR>", "Next Tab" },
    ["c"] = { "<cmd>tabclose<CR>", "Close Tab" },
    ["C"] = { "<cmd>tabonly<CR>", "Close All Tabs" },
    ["l"] = { "<cmd>tabs<CR>", "List Tabs" },
    ["n"] = { "<cmd>tabnew<CR>", "New Tab" },
  },
  -- cwindow
  cw = {
    name = "Cwindow (QuickFix)",
    ["["] = { "<cmd>cprev<CR>", "Previous Error" },
    ["]"] = { "<cmd>cnext<CR>", "Next Error" },
    ["o"] = { "<cmd>copen<CR>", "Open Cwindow" },
    ["c"] = { "<cmd>cclose<CR>", "Close Cwindow" },
    ["w"] = { "<cmd>cwindow<CR>", "Cwindow Size" },
  },
  -- grep
  s = {
    name = "Search",
    ["s"] = { "<cmd>grep<CR>", "Search for symbol" },
    ["S"] = { "<cmd>grepadd<CR>", "Search for symbol, add to results" },
    ["["] = { "<cmd>cprev<CR>", "Previous Match" },
    ["]"] = { "<cmd>cnext<CR>", "Next Match" },
    ["o"] = { "<cmd>copen<CR>", "Open Cwindow" },
    ["c"] = { "<cmd>cclose<CR>", "Close Cwindow" },
    ["w"] = { "<cmd>cwindow<CR>", "Cwindow Size" },
  },
  ["]"] = { "<cmd>cnext<CR>", "Next quickfix entry" },
  ["["] = { "<cmd>cprev<CR>", "Previous quickfix entry" },
  prefix = "<leader>",
  }
)
EOF

" ragtag
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

" Conditional include of ~/.vimrc.local
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local	
endif
