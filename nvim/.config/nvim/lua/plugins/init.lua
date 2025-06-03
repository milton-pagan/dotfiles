-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core tools
  { "nvim-lua/plenary.nvim" }, -- dependency for others
  { "nvim-telescope/telescope.nvim", tag = "0.1.3" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- FZF-like functionality
  { "junegunn/fzf", build = "./install --all" },
  { "junegunn/fzf.vim" },

  -- Git
  { "tpope/vim-fugitive" },
  { "stsewd/fzf-checkout.vim" },

  -- File tree and session
  { "preservim/nerdtree" },
  { "mbbill/undotree" },
  { "mhinz/vim-startify" },

  -- Colorschemes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- UI
  { "vim-airline/vim-airline" },
  { "vim-airline/vim-airline-themes" },

  -- Syntax & highlighting
  { "sheerun/vim-polyglot" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "vim-utils/vim-man" },
  { "ap/vim-css-color" },

  -- Markdown & LaTeX
  { "lervag/vimtex" },
  { "ferrine/md-img-paste.vim" },
  { "vim-pandoc/vim-pandoc" },
  { "vim-pandoc/vim-pandoc-syntax" },

  -- Editing power-ups
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-sensible" },
  { "preservim/nerdcommenter" },
  { "godlygeek/tabular" },

  -- Language server setup (replacing coc.nvim)
  -- { "neovim/nvim-lspconfig" },
  -- { "williamboman/mason.nvim" },
  --{ "williamboman/mason-lspconfig.nvim" },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },

  -- Others
  { "christoomey/vim-tmux-navigator" },
  {
    'neoclide/coc.nvim',
    branch = 'release',
    build = 'npm install',
    event = { 'InsertEnter', 'CmdlineEnter' },
  }
})

