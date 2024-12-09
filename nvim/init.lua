-- Set Leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

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

-- Visual feedback
vim.o.showmode = true -- Show current mode
vim.o.showcmd = true -- Display incomplete commands

vim.opt.shortmess:append("rnixnm") -- Suppress unnecessary messages

-- Command abbreviations, so we can type :rg and it becomes :grep
vim.cmd([[
    function! CommandCabbr(abbreviation, expansion)
	execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
    endfunction

    command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)
    CommandCabbr ccab CommandCabbr
    CommandCabbr rg grep
]])

-- Install plugin manager
vim.cmd([[
call plug#begin()

" LSP
Plug 'neovim/nvim-lspconfig'            " LSP
Plug 'glepnir/lspsaga.nvim'             " Code Actions, etc.
Plug 'ray-x/lsp_signature.nvim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'             " Complete on LSP
Plug 'hrsh7th/cmp-buffer'               " Complete on buffer contents
Plug 'hrsh7th/cmp-path'                 " Complete on file-systems paths

" Snippets
Plug 'L3MON4D3/LuaSnip'                   
Plug 'saadparwaiz1/cmp_luasnip'         " Complete on snippets
Plug 'rafamadriz/friendly-snippets'     " Predefined snippets
Plug 'honza/vim-snippets', { 'on': [] } " Prevents autoload, we just want the snippets, luasnip will load them

" Status Line
Plug 'nvim-lualine/lualine.nvim'

" Tree, explorer
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'nvim-treesitter/playground'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-tree/nvim-web-devicons'

" Terminal
Plug 'akinsho/toggleterm.nvim'

" Keys, navigation
Plug 'folke/which-key.nvim'
Plug 'christoomey/vim-tmux-navigator'

" Fzf and MRU list
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'yegappan/mru'

" Git
Plug 'mhinz/vim-signify'    " Git in the gutter
Plug 'tpope/vim-fugitive'   " Git commands
Plug 'rhysd/committia.vim'  " Git commit editor

" ChatGPT integration
Plug 'jackMort/ChatGPT.nvim', { 'do': 'pip install -r requirements.txt' }
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" GitHub Copilot
Plug 'github/copilot.vim'

" colorscheme
Plug 'sainnhe/sonokai'

" Tests
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-neotest/neotest'

Plug 'nvim-neotest/neotest-python'
Plug 'marilari88/neotest-vitest'
Plug 'zidhuss/neotest-minitest'
Plug 'rouge8/neotest-rust'

call plug#end()
]])

-- prevent vim-snippets from loading, we are using luasnip
vim.g.loaded_vim_snippets = 1

local plug_installed = vim.fn.empty(vim.fn.glob(vim.fn.stdpath("data") .. '/plugged/vim-snippets/snippets')) == 1
if plug_installed then
    vim.cmd('PlugInstall --sync | q')
end

-- fzf and MRU
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
-- DO THIS, but for neotest: vim.api.nvim_set_keymap('n', '<Leader>r', ':TestNearest<CR>', { noremap = true, silent = true })


-- ChatGPT
vim.api.nvim_set_keymap('n', '<Leader>c', ':ChatGPT<CR>', { noremap = true, silent = true })

-- Clear highlights
vim.api.nvim_set_keymap("n", "<esc>", "<esc>:nohl<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-c>", "<esc>:close<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    'n',
    '<leader>X',
    ':lua for _, win in ipairs(vim.api.nvim_list_wins()) do local config = vim.api.nvim_win_get_config(win); if config.relative ~= "" then vim.api.nvim_win_close(win, true) end end<CR>',
    { noremap = true, silent = true }
)

-- Tree explorer
vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent= true })
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
local luasnip = require('luasnip')

-- Initialize LSP Saga for enhanced UI
lspsaga.setup({
    ui = { border = "rounded" },
    outline = { win_width = 50 },
    code_action = {
        enable = true,
        show_server_name = true,
        extend_git_signs = true,
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
require("luasnip.loaders.from_snipmate").lazy_load({
    paths = vim.fn.stdpath("data") .. "/plugged/vim-snippets/snippets"
})

-- Auto-completion setup
cmp.setup({
    completion = {
        keyword_length = 2,
    },
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ["k"] = cmp.mapping.select_prev_item(),
        ["j"] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Esc>"] = cmp.mapping.close(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          -- behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'path' },
    },
})

-- LSP 
local function on_attach(client, bufnr)
    local buf_map = function(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
    end

    -- Only map keys if the LSP server supports the feature
    if client.server_capabilities.hoverProvider then
        buf_map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
    end

    if client.server_capabilities.definitionProvider then
        buf_map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>')
    end

    if client.server_capabilities.referencesProvider then
        buf_map('n', 'gr', '<cmd>Lspsaga finder<CR>')
    end

    if client.server_capabilities.codeActionProvider then
        buf_map('n', '<leader>a', ':lua ShowCodeActions()<CR>')
    end

    if client.server_capabilities.renameProvider then
        buf_map('n', '<leader>r', '<cmd>Lspsaga rename<CR>')
    end

    if client.server_capabilities.diagnosticProvider then
        buf_map('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>')
        buf_map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
        buf_map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
    end

    -- Additional LSP Saga functionality
    buf_map('n', '<leader>o', '<cmd>Lspsaga outline<CR>')
end

function ShowCodeActions()
    local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- Request code actions
    --

    vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, result, ctx, config)
        if not result or vim.tbl_isempty(result) then
            print("No code actions available")
            return
        end
        vim.defer_fn(function()
            vim.cmd("Lspsaga code_action")
        end, 50)
    end)
end

-- LSP capabilities for completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150, -- Improve responsiveness
        },
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

-- Deal with venvs
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
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
            diagnostics = {
                disabled = { "unresolved-module" }, -- Suppress noisy "not part of a crate" errors
            },
        }
    }
})


-- Test

require("neotest").setup({
  adapters = {
    require("neotest-python"),
    require("neotest-rust"),
    require("neotest-minitest"),
    require("neotest-vitest")
  }
})


-- WhichKey setup
wk = require("which-key")
wk.setup({
  delay = 200,
})

wk.add({
    { ";L", group = "LSPSaga" },
    { ";LD", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Jump to previous diagnostic" },
    { ";LT", "<cmd>Lspsaga open_floaterm<CR>", desc = "Open terminal" },
    { ";La", "<cmd>Lspsaga code_action<CR>", desc = "Code action" },
    { ";Ld", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics" },
    { ";Lf", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
    { ";Ln", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Jump to next diagnostic" },
    { ";Lr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
    { ";Ls", "<cmd>Lspsaga signature_help<CR>", desc = "Signature help" },
    { ";Lt", "<cmd>Lspsaga preview_definition<CR>", desc = "Preview definition" },
    { ";T", group = "Tabs" },
    { ";TC", "<cmd>tabonly<CR>", desc = "Close All Tabs" },
    { ";T[", "<cmd>tabprev<CR>", desc = "Previous Tab" },
    { ";T]", "<cmd>tabnext<CR>", desc = "Next Tab" },
    { ";Tc", "<cmd>tabclose<CR>", desc = "Close Tab" },
    { ";Tl", "<cmd>tabs<CR>", desc = "List Tabs" },
    { ";Tn", "<cmd>tabnew<CR>", desc = "New Tab" },
    { ";[", "<cmd>cprev<CR>", desc = "Previous quickfix entry" },
    { ";]", "<cmd>cnext<CR>", desc = "Next quickfix entry" },
    { ";b", group = "Buffers" },
    { ";bD", "<cmd>bufdo bd<CR>", desc = "Delete All Buffers" },
    { ";b[", "<cmd>bp<CR>", desc = "Previous Buffer" },
    { ";b]", "<cmd>bn<CR>", desc = "Next Buffer" },
    { ";bd", "<cmd>bd<CR>", desc = "Delete Buffer" },
    { ";bl", "<cmd>ls<CR>", desc = "List Buffers" },
    { ";c", group = "ChatGPT" },
    { ";cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
    { ";f", "<cmd>FZF<CR>", desc = "Fuzzy Open File" },
    { ";g", group = "Git" },
    { ";gA", "<cmd>Git add -A<CR>", desc = "Git Add All" },
    { ";gC", "<cmd>Git checkout", desc = "Git Checkout" },
    { ";gF", "<cmd>Git fetch --all<CR>", desc = "Git Fetch All" },
    { ";gP", "<cmd>Git pull<CR>", desc = "Git Pull" },
    { ";gT", "<cmd>Git stash pop<CR>", desc = "Git Stash Pop" },
    { ";gb", "<cmd>Git blame<CR>", desc = "Git Blame" },
    { ";gc", "<cmd>Git commit<CR>", desc = "Git Commit" },
    { ";gd", "<cmd>Gdiffsplit<CR>", desc = "Git Diff" },
    { ";gf", "<cmd>Git fetch<CR>", desc = "Git Fetch" },
    { ";gh", "<cmd>Git hist<CR>", desc = "Git history" },
    { ";gl", "<cmd>Git log<CR>", desc = "Git Log" },
    { ";gp", "<cmd>Git push --force-with-lease --force-if-includes<CR>", desc = "Git Push" },
    { ";gr", " <cmd>Git rebase -i origin/main<CR>", desc = "Git rebase" },
    { ";gs", "<cmd>Git status<CR>", desc = "Git Status" },
    { ";gt", "<cmd>Git stash<CR>", desc = "Git Stash" },
    { ";l", group = "LSP" },
    { ";lC", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", desc = "Outgoing calls" },
    { ";lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to declaration" },
    { ";lR", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
    { ";lS", "<cmd>lua vim.lsp.buf.workspace_symbol_search()<CR>", desc = "Workspace symbol search" },
    { ";la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
    { ";lc", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", desc = "Incoming calls" },
    { ";ld", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition" },
    { ";lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", desc = "Format code" },
    { ";lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Show hover information" },
    { ";li", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to implementation" },
    { ";ln", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },
    { ";lp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", desc = "Previous diagnostic" },
    { ";lr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Find references" },
    { ";ls", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", desc = "Document symbols" },
    { ";lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Go to type definition" },
    { ";m", "<cmd>FZFMru<CR>", desc = "Fuzzy Open MRU" },
    { ";s", group = "Search" },
    { ";sS", "<cmd>grepadd<CR>", desc = "Search for symbol, add to results" },
    { ";s[", "<cmd>cprev<CR>", desc = "Previous Match" },
    { ";s]", "<cmd>cnext<CR>", desc = "Next Match" },
    { ";sc", "<cmd>cclose<CR>", desc = "Close Cwindow" },
    { ";so", "<cmd>copen<CR>", desc = "Open Cwindow" },
    { ";ss", "<cmd>grep<CR>", desc = "Search for symbol" },
    { ";sw", "<cmd>cwindow<CR>", desc = "Cwindow Size" },
    { ";t", group = "Test" },
    { ";tg", "<cmd>TestVisit<CR>", desc = "Test Visit" },
    { ";tl", "<cmd>TestLast<CR>", desc = "Test Last" },
    { ";ts", "<cmd>TestSuite<CR>", desc = "Test Suite" },
    { ";tt", "<cmd>TestNearest<CR>", desc = "Test Nearest" },
    { ";w", group = "CWindow)" },
    { ";w[", "<cmd>cprev<CR>", desc = "Previous Error" },
    { ";w]", "<cmd>cnext<CR>", desc = "Next Error" },
    { ";wc", "<cmd>cclose<CR>", desc = "Close Cwindow" },
    { ";wo", "<cmd>copen<CR>", desc = "Open Cwindow" },
    { ";ww", "<cmd>cwindow<CR>", desc = "Cwindow Size" },
    {
      mode = { "n", "v" },
      { ";ca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests" },
      { ";cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
      { ";ce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction" },
      { ";cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
      { ";cg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
      { ";ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
      { ";cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
      { ";co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code" },
      { ";cr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
      { ";cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
      { ";ct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate" },
      { ";cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
    },
})
