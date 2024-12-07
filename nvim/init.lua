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
vim.api.nvim_set_keymap("n", "<esc>", "<esc>:nohl<cr>", { noremap = true, silent = true }) -- Clear highlights with <esc>

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
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
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

" ChatGPT integration
Plug 'nvim-lua/plenary.nvim'
Plug 'jackMort/ChatGPT.nvim', { 'do': 'pip install -r requirements.txt' }
Plug 'MunifTanjim/nui.nvim'

" GitHub Copilot
Plug 'github/copilot.vim'

" colorscheme
Plug 'sainnhe/sonokai'

call plug#end()
]])

-- Auto-install plugins if necessary
local plug_installed = vim.fn.empty(vim.fn.glob('~/.vim/plugged/*')) == 1
if plug_installed then
    vim.cmd('PlugInstall --sync | q')
end


-- t_Co is a string, convert to int first:
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

-- Enable system clipboard
-- vim.cmd([[
-- if has('clipboard')
--     set clipboard+=unnamedplus
-- endif
-- ]])
-- Clipboard
vim.opt.clipboard:append("unnamedplus") -- Share clipboard with system

-- Keybindings for clipboard operations (optional)
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true }) -- Copy to system clipboard
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true }) -- Paste from system clipboard
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true, silent = true }) -- Paste before in normal mode

-- Key mappings
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>r', ':TestNearest<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>c', ':ChatGPT<CR>', { noremap = true, silent = true }) -- Open ChatGPT

-- LSP Setup
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local saga = require('lspsaga')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Initialize LSP Saga for enhanced UI
saga.setup({})

local servers = {
    'pyright', 'rust_analyzer', 'bashls', 'yamlls', 'ts_ls',
    'gopls', 'kotlin_language_server', 'eslint'
}

-- Auto-completion setup
cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
})

-- Generic LSP on_attach function
local function on_attach(client, bufnr)
    local buf_map = function(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
    end

    -- Keybindings for LSP
    buf_map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')           -- Show type information
    buf_map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>')    -- Go to definition
    buf_map('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>')         -- Find references/implementations
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

-- Auto-install Treesitter parsers
local parsers = require('nvim-treesitter.parsers').get_parser_configs()
for parser, _ in pairs(parsers) do
    if not parsers[parser].is_installed then
        -- vim.cmd('TSInstall ' .. parser)
    end
end

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

-- Context Window
require('lspsaga').setup({
    ui = { border = "rounded" },
    outline = { win_width = 50 },
})

-- Terminal
require('toggleterm').setup({
    direction = 'horizontal',
    size = 15,
})

-- Lualine
require('lualine').setup({
    options = { theme = 'auto' },
})

-- ChatGPT Setup
require("chatgpt").setup({
    keymaps = {
        submit = "<C-s>", -- Submit query to ChatGPT
    }
})
-- keybinding to open ChatGPT
vim.api.nvim_set_keymap('n', '<Leader>c', ':ChatGPT<CR>', { noremap = true, silent = true })

-- GitHub Copilot: Enable by default
vim.g.copilot_enabled = true

-- ToggleTerm: C-t to open, C-w to move between windows
require('toggleterm').setup({
    direction = 'horizontal',
    size = 15,
    open_mapping = [[<C-t>]],
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

-- ToggleTerm: Auto-enter Insert Mode when switching to a terminal window
vim.cmd([[
  augroup TerminalInsertMode
    autocmd!
    autocmd BufEnter term://* startinsert
  augroup END
]])

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

vim.api.nvim_set_keymap('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':Se<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>v', ':vspl<CR>:Ex<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>-', ':sp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>\'', ':vsp<CR>', { noremap = true, silent = true })


-- Treesitter Playground setup
require("nvim-treesitter.configs").setup({
    playground = {
        enable = true,
        updatetime = 25, -- Debounced time for highlighting nodes (in ms)
        persist_queries = false, -- Whether the query persists across vim sessions
    },
})

vim.api.nvim_set_keymap('n', '<leader>t', ':TSPlaygroundToggle<CR>', { noremap = true, silent = true })

-- If there is a poetry.lock file, use the virtual environment
-- defined in the Poetry environment
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
