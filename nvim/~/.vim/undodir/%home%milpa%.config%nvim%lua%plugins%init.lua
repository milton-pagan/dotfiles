Vim�UnDo� �k�n���^I� �8d�A ��M���q�9�   M   })    L          
       
   
   
    g�E�    _�                             ����                                                                                                                                                                                                                                                                                                                                                  V        g�C0    �         ?      !  { "sainnhe/gruvbox-material" },�         ?    �                  { "morhetz/gruvbox" },   !  { "arcticicestudio/nord-vim" },5��                                ;               �                     ;   �             ;       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             g�D�     �         L      vim.opt.rtp:pre�         L    �         L    �         G          "https:�      	   G    �      	   G    �      	   B      if not vim.loop.fs_sta�         B    �          @       �         @    �          ?    5��                                                  �                                          j       �                        j               `       �                         �                      �                        �               P       �                         *                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             g�D�    �         L    5��                          9                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             g�D�     �         M      return {5��                          :                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             g�D�     �         M      require("lazy").setup(return {5��                         P                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             g�D�     �         M      require("lazy").setup( {5��                         P                     5�_�                    M       ����                                                                                                                                                                                                                                                                                                                                                             g�D�    �   L              }5��    L                     �                     5�_�      	                      ����                                                                                                                                                                                                                                                                                                                                      M          V   \    g�E:    �   K                { "christoomey/vim-t�   L            �   J                �   K            �   D                { "hrsh7th/cmp-buffer" },�   E            �   :                { "godlygeek/�   ;            �   6                �   7            �   5              	  -- Edit�   6            �   1                { "ferrine/md-i�   2            �   /                { "iamcco/markdown�   0            �   +                { "vim-utils/v�   ,            �   "              )  { "catppuccin/nvim", name = "catppuccin�   #            �                  �               �                 if not vim.loop.fs_sta�               �                  -- Bootstrap Lazy.nvim�               �             L   <local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"   &if not vim.loop.fs_stat(lazypath) then     vim.fn.system({   
    "git",       "clone",       "--filter=blob:none",   -    "https://github.com/folke/lazy.nvim.git",       "--branch=stable",       lazypath,     })   end   vim.opt.rtp:prepend(lazypath)       require("lazy").setup({     -- Core tools   7  { "nvim-lua/plenary.nvim" }, -- dependency for others   5  { "nvim-telescope/telescope.nvim", tag = "0.1.3" },   A  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },         -- FZF-like functionality   0  { "junegunn/fzf", build = "./install --all" },     { "junegunn/fzf.vim" },         -- Git     { "tpope/vim-fugitive" },      { "stsewd/fzf-checkout.vim" },         -- File tree and session     { "preservim/nerdtree" },     { "mbbill/undotree" },     { "mhinz/vim-startify" },         -- Colorschemes   =  { "catppuccin/nvim", name = "catppuccin", priority = 1000 }         -- UI      { "vim-airline/vim-airline" },   '  { "vim-airline/vim-airline-themes" },         -- Syntax & highlighting     { "sheerun/vim-polyglot" },   =  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },     { "vim-utils/vim-man" },     { "ap/vim-css-color" },         -- Markdown & LaTeX   [  { "iamcco/markdown-preview.nvim", build = "cd app && npm install", ft = { "markdown" } },     { "lervag/vimtex" },   !  { "ferrine/md-img-paste.vim" },     { "vim-pandoc/vim-pandoc" },   %  { "vim-pandoc/vim-pandoc-syntax" },         -- Editing power-ups     { "tpope/vim-surround" },     { "tpope/vim-repeat" },     { "tpope/vim-sensible" },      { "preservim/nerdcommenter" },     { "godlygeek/tabular" },       /  -- Language server setup (replacing coc.nvim)     { "neovim/nvim-lspconfig" },      { "williamboman/mason.nvim" },   *  { "williamboman/mason-lspconfig.nvim" },         -- Autocompletion     { "hrsh7th/nvim-cmp" },     { "hrsh7th/cmp-nvim-lsp" },     { "hrsh7th/cmp-buffer" },     { "hrsh7th/cmp-path" },     { "L3MON4D3/LuaSnip" },   !  { "saadparwaiz1/cmp_luasnip" },   %  { "rafamadriz/friendly-snippets" },         -- Others   '  { "christoomey/vim-tmux-navigator" },   })5��           L                      �              �                                                  �                                          j       �                         j                     �                      )   z              �       �    "   )           	      j              �       �    +                    Z              P       �    /                    �              p       �    1                 	                 `       �    5   	                 z                     �    6                    �              �       �    :              
      
                    �    D                                  �       �    J                    �                      �    K                     �                     5�_�      
           	   0       ����                                                                                                                                                                                                                                                                                                                                                             g�E�     �   /   0          [  { "iamcco/markdown-preview.nvim", build = "cd app && npm install", ft = { "markdown" } },5��    /                      �      \               5�_�   	               
   L        ����                                                                                                                                                                                                                                                                                                                                                             g�E�    �   K   M   M      }) 5��    K                     r                     5��