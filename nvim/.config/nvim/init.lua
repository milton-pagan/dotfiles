-- ====================
-- General Settings
-- ====================

-- Enable hidden buffers
vim.opt.hidden = true

-- Disable error bells
vim.opt.errorbells = false

-- Disable search highlighting
vim.opt.hlsearch = false

-- Set indentation options
vim.opt.tabstop = 4                                      -- Number of spaces for tab
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4                                   -- Indentation width
vim.opt.expandtab = true                                 -- Convert tabs to spaces
vim.opt.smartindent = true                               -- Enable smart indentation

-- Line numbering
vim.opt.number = true                                    -- Show line numbers
vim.opt.relativenumber = true                            -- Show relative line numbers

-- Other useful settings
vim.opt.wrap = false                                     -- Disable line wrapping
vim.opt.smartcase = true                                 -- Case-sensitive search when appropriate
vim.opt.swapfile = false                                 -- Disable swap files
vim.opt.backup = false                                   -- Disable backup files
vim.opt.writebackup = false                              -- Disable write backup
vim.opt.updatetime = 300                                 -- Faster update time
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'   -- Set undo directory
vim.opt.undofile = true                                  -- Enable undo file
vim.opt.incsearch = true                                 -- Enable incremental search
vim.opt.wildmenu = true                                  -- Enable wildmenu
vim.opt.termguicolors = true                             -- Enable 24-bit RGB color in the terminal

-- Leader key
vim.g.mapleader = " "  -- Set leader key to space

-- ====================
-- Plugin Manager: Lazy.nvim
-- ====================
require("plugins")


-- ====================
-- Key Mappings (Remaps)
-- ====================


-- Window navigation
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

-- File Explorer
vim.keymap.set('n', '<leader>pt', vim.cmd.NERDTreeToggle)
vim.keymap.set('n', '<leader>pv', vim.cmd.NERDTreeFind)

-- UndoTree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Search plugins
vim.keymap.set('n', '<leader>rg', vim.cmd.Rg)       -- Ripgrep search
vim.keymap.set('n', '<C-p>', vim.cmd.GFiles)         -- Fuzzy search files
vim.keymap.set('n', '<Leader>pf', vim.cmd.Files)     -- Fuzzy find files

-- Visual mode mappings
vim.keymap.set('v', '<leader>pp', '"_dP')            -- Paste without overriding the clipboard

-- Key mapping for showing documentation
vim.keymap.set('n', 'K', function()                   -- Show documentation
  _G.show_documentation()
end, { silent = true })

-- Source the config (useful for debugging)
vim.keymap.set('n', '<Leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

-- ====================
-- Functions
-- ====================

-- Show documentation function
function _G.show_documentation()
  if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
    vim.cmd('help ' .. vim.fn.expand('<cword>'))
  else
    vim.fn['coc#rpc#request']('doHover', '')
  end
end

-- Trim trailing whitespace function
function TrimWhitespace()
  local save = vim.fn.winsaveview()           -- Save the view before modifying the buffer
  vim.cmd('%s/\\s\\+$//e')                    -- Remove trailing whitespace from all lines
  vim.fn.winrestview(save)                     -- Restore the saved view
end

-- Trim whitespace on file write
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = TrimWhitespace,
})

-- Autocmd to trim whitespace before saving
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "highlight_yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = "highlight_yank",
  pattern = "*",
  callback = function()
    TrimWhitespace()
  end,
})

-- ====================
-- Color Scheme & Appearance
-- ====================

-- Set colorscheme
vim.cmd.colorscheme "catppuccin-mocha"

-- Set airline theme
vim.g.airline_theme = 'catppuccin'

-- ====================
-- CoC Config
-- ====================

-- Function to check backspace (Lua version)
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Mapping for <TAB> key to trigger completion or snippet jump
vim.keymap.set('i', '<Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['coc#_select_confirm']()
  elseif vim.fn['coc#expandableOrJumpable']() == 1 then
    return vim.fn['coc#rpc#request']('doKeymap', {'snippets-expand-jump', ''})
  elseif _G.check_back_space() then
    return '<Tab>'
  else
    return vim.fn['coc#refresh']()
  end
end, { expr = true, silent = true })

-- Mapping for <CR> (Enter) key for completion confirmation
vim.keymap.set('i', '<CR>', function()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['coc#_select_confirm']()
  elseif vim.fn.complete_info().selected ~= -1 then
    return '<C-y>'
  else
    return '<C-g>u<CR>'
  end
end, { expr = true, silent = true })

-- Set the next snippet expansion key to <Tab>
vim.g.coc_snippet_next = '<Tab>'


-- Set CoC global extensions
vim.g.coc_global_extensions = {
  'coc-snippets',
  'coc-pairs',
  'coc-tsserver',
  'coc-eslint',
  'coc-prettier',
  'coc-json',
  'coc-pyright',
  'coc-java',
  'coc-go',
  'coc-highlight',
  'coc-html',
  'coc-css',
  'coc-xml',
  'coc-markdownlint',
  'coc-clangd',
  'coc-vimtex',
}
