-- 
-- Set Leader key
vim.g.mapLeader = ','
vim.g.maplocalLeader = ','

-- Basic settings
vim.o.compatible = false -- Disable vi compatibility

-- Statusline
-- vim.o.statusline = "%F%m%r%h%w [%Y:%{&ff}] [A=\\%03.3b] [0x=\\%02.2B] [%l/%L,%v][%p%%] %{fugitive#statusline()}"

-- Performance
vim.o.lazyredraw = true -- Don't redraw during macros
vim.o.ttyfast = true -- Fast local tty

-- Disable annoying bells
vim.o.visualbell = true -- Disable visual beep
vim.o.errorbells = false -- Disable error bells

-- History
vim.o.history = 1000 -- Keep command history

-- Backspace
vim.o.backspace = "indent,eol,start" -- Enable flexible backspace behavior

-- Line numbers and search
vim.o.number = true -- Show line numbers
vim.o.hlsearch = true -- Highlight search matches
vim.o.incsearch = true -- Enable incremental search
vim.o.smartcase = true -- Case-sensitive search if uppercase letters are used
vim.o.showmatch = true -- Highlight matching brackets

-- Scrolling
vim.o.scrolloff = 8 -- Keep 8 lines visible above/below cursor
vim.o.sidescrolloff = 5 -- Keep 5 columns visible left/right of cursor

-- Grep
vim.o.grepprg = "rg --vimgrep" -- Use ripgrep for :grep
vim.opt.grepformat:append("%f:%l:%c:%m")

-- Leader keys
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Command abbreviations
vim.cmd([[
    function! CommandCabbr(abbreviation, expansion)
	execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
    endfunction

    command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)
    CommandCabbr ccab CommandCabbr
    CommandCabbr rg grep
]])

-- Visual feedback
vim.o.showmode = true -- Show current mode
vim.o.showcmd = true -- Display incomplete commands
vim.opt.shortmess:append("rnixnm") -- Suppress unnecessary messages

-- Install plugin manager
vim.cmd([[
call plug#begin('~/.vim/plugged')

" Plugin manager
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'vim-test/vim-test'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/toggleterm.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'folke/which-key.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'yegappan/mru'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'

" ChatGPT integration
Plug 'jackMort/ChatGPT.nvim', { 'do': 'pip install -r requirements.txt' }
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" GitHub Copilot
Plug 'github/copilot.vim'

" colorscheme
Plug 'sainnhe/sonokai'

" NerdTree
Plug 'preservim/nerdtree'

call plug#end()
]])

-- Auto-install plugins if necessary
local plug_installed = vim.fn.empty(vim.fn.glob('~/.vim/plugged/*')) == 1
if plug_installed then
    vim.cmd('PlugInstall --sync | q')
end

vim.g.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --max-filesize 1M'

if vim.g.syntax_on then
    vim.cmd("syntax reset")
end

local status_ok, _ = pcall(vim.cmd, "colorscheme sonokai")
if not status_ok then
    vim.api.nvim_echo({
        { "Sonokai colorscheme not found. Please install the plugin or change the colorscheme.", "WarningMsg" }
    }, true, {})
end

-- General settings
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.signcolumn = "yes"

-- Enable system clipboard
vim.opt.clipboard:append("unnamedplus") -- Share clipboard with system

-- Key mappings
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>r', ':TestNearest<CR>', { noremap = true, silent = true })

-- LSP Code Actions
vim.api.nvim_set_keymap('n', '<Leader>a', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>a', ':Lspsaga range_code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>o', ':Lspsaga outline<CR>', { noremap = true, silent = true })

-- ChatGPT
vim.api.nvim_set_keymap('n', '<Leader>c', ':ChatGPT<CR>', { noremap = true, silent = true })

-- Clear highlights
vim.api.nvim_set_keymap("n", "<esc>", "<esc>:nohl<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-c>", "<esc>:close<cr>", { noremap = true, silent = true })

-- NERDTreeToggle
vim.api.nvim_set_keymap('n', '<leader>x', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })
-- Split Explore
vim.api.nvim_set_keymap('n', '<leader>s', ':Se<CR>', { noremap = true, silent = true })
-- Vsplit Explore
vim.api.nvim_set_keymap('n', '<leader>v', ':vspl<CR>:Ex<CR>', { noremap = true, silent = true })
-- Tab Explore
vim.api.nvim_set_keymap('n', '<leader>T', ':tabe<CR>:Ex<CR>', { noremap = true, silent = true })

-- Splits
vim.api.nvim_set_keymap('n', '<leader>-', ':sp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>\'', ':vsp<CR>', { noremap = true, silent = true })

-- LSP Setup
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local lspsaga = require('lspsaga')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Initialize LSP Saga for enhanced UI
lspsaga.setup({
    ui = { border = "rounded" },
    outline = { win_width = 50 },
    code_action = {
        enable = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
        keys = {
            quit = "<Esc>", -- Keybinding to quit the code action menu
        },
    },
    code_action_icon = "💡",
    finder_definition_icon = "📖",
    finder_reference_icon = "🔍",
    finder_action_keys = {
        open = "o", vsplit = "s", split = "i", quit = "q", scroll_down = "<C-f>", scroll_up = "<C-b>"
    },
})

local servers = {
    'pyright', 'rust_analyzer', 'bashls', 'yamlls', 'ts_ls',
    'gopls', 'kotlin_language_server', 'eslint'
}

require("luasnip.loaders.from_vscode").lazy_load()

-- Auto-completion setup
cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["k"] = cmp.mapping.select_prev_item(),
        ["j"] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        -- Add tab support
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Esc>"] = cmp.mapping.close(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' },
    },
})

---- Generic LSP on_attach function
local function on_attach(client, bufnr)
    local buf_map = function(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
    end

    -- Keybindings for LSP
    buf_map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')           -- Show type information
    buf_map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>')    -- Go to definition
    buf_map('n', 'gr', '<cmd>Lspsaga finder<CR>')         -- Find references/implementations
    buf_map('n', '<leader>a', '<cmd>Lspsaga code_action<CR>') -- Trigger code actions
    buf_map('n', '<leader>r', '<cmd>Lspsaga rename<CR>')      -- Rename symbol
    buf_map('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>') -- Show line diagnostics
    buf_map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>') -- Jump to previous diagnostic
    buf_map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>') -- Jump to next diagnostic
end

-- LSP capabilities for completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup each language server
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- Diagnostics settings
vim.diagnostic.config({
    virtual_text = true, -- Show diagnostics inline
    signs = true,
    underline = true,
    update_in_insert = false, -- Don't update diagnostics while typing
})

-- Treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "javascript", "typescript", "python", "rust", "kotlin",
        "bash", "yaml", "lua", "dockerfile"
    },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
})

-- Completion
cmp.setup({
   snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})


-- Terminal
require('toggleterm').setup({
    direction = 'horizontal',
    size = 15,
})

-- ToggleTerm: <Leader>t to open, <Esc><C-w>[hjkl] to move between windows
require('toggleterm').setup({
    direction = 'horizontal',
    size = 15,
    open_mapping = [[<Leader>t]],
    on_open = function(term)
        vim.api.nvim_buf_set_keymap(
            term.bufnr,
            't',
            '<C-w>',
            [[<C-\><C-n><C-w>]],
            { noremap = true, silent = true }
        )
    end,
})

-- Lualine
require('lualine').setup({
    options = { theme = 'auto' },
})

-- ChatGPT Setup
require("chatgpt").setup({
    openai_params = {
        model = "gpt-4o-mini",
    },
    keymaps = {
        submit = "<C-s>", -- Submit query to ChatGPT
    }
})
-- GitHub Copilot: Enable by default
vim.g.copilot_enabled = true


-- Toggle between relative, absolute, and disabled line numbers
vim.api.nvim_set_keymap('n', '<leader>n', [[:lua ToggleLineNumbers()<CR>]], { noremap = true, silent = true })

function ToggleLineNumbers()
    if vim.wo.number and vim.wo.relativenumber then
        -- Currently relative, switch to absolute
        vim.wo.relativenumber = false
    elseif vim.wo.number then
        -- Currently absolute, disable line numbers
        vim.wo.number = false
    else
        -- Currently disabled, switch to relative
        vim.wo.number = true
        vim.wo.relativenumber = true
    end
end

-- Python LSP setup
local python_path = "python"

local poetry_lock = vim.fn.glob("poetry.lock")
if vim.fn.empty(poetry_lock) == 0 then
    -- Get the Poetry environment path
    local poetry_venv = vim.fn.trim(vim.fn.system("poetry env info --path"))
    python_path = poetry_venv .. "/bin/python"
end

local pdm_lock = vim.fn.glob("pdm.lock")
if vim.fn.empty(pdm_lock) == 0 then
    local pdm_venv = vim.fn.trim(vim.fn.system("pdm --venv"))
    python_path = pdm_venv .. "/bin/python"
end

local venv = vim.fn.glob("venv")
if vim.fn.empty(venv) == 0 then
    python_path = "venv/bin/python"
end

local dotvenv = vim.fn.glob(".venv")
if vim.fn.empty(dotvenv) == 0 then
    python_path = ".venv/bin/python"
end

lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" }, -- Use global pyright-langserver
    settings = {
        python = {
            pythonPath = python_path, -- Use the Poetry virtual environment
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
})

-- Rust LSP Setup
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- WhichKey setup
wk = require("which-key")
wk.setup()

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
      S = { "<cmd>lua vim.lsp.buf.workspace_symbol_search()<CR>", "Workspace symbol search" },
      D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
      n = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next diagnostic" },
      p = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
    },
  L = {
    name = "LSPSaga",
      a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
      d = { "<cmd>Lspsaga hover_doc<CR>", "Hover doc" },
      f = { "<cmd>Lspsaga finder<CR>", "LSP Finder" },
      r = { "<cmd>Lspsaga rename<CR>", "Rename" },
      s = { "<cmd>Lspsaga signature_help<CR>", "Signature help" },
      t = { "<cmd>Lspsaga preview_definition<CR>", "Preview definition" },
      T = { "<cmd>Lspsaga open_floaterm<CR>", "Open terminal" },
      d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
      D = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to previous diagnostic" },
      n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next diagnostic" },
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
  T = {
    name = "Tabs",
    ["["] = { "<cmd>tabprev<CR>", "Previous Tab" },
    ["]"] = { "<cmd>tabnext<CR>", "Next Tab" },
    ["c"] = { "<cmd>tabclose<CR>", "Close Tab" },
    ["C"] = { "<cmd>tabonly<CR>", "Close All Tabs" },
    ["l"] = { "<cmd>tabs<CR>", "List Tabs" },
    ["n"] = { "<cmd>tabnew<CR>", "New Tab" },
  },
  -- cwindow
  w = {
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
