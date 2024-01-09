-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- print('hello from packer')

-- local ensure_packer = function()
--   local fn = vim.fn
--   local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--   if fn.empty(fn.glob(install_path)) > 0 then
--     fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--     vim.cmd [[packadd packer.nvim]]
--     return true
--   end
--   return false
-- end

-- local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use "nvim-lua/plenary.nvim"

    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
	    -- or                            , branch = '0.1.x',
	    requires = { {'nvim-lua/plenary.nvim'} }
    }

    use('EdenEast/nightfox.nvim')

    -- use({
    --   'rose-pine/neovim',
    --   as = 'rose-pine',
    --   config = function()
    --     vim.cmd('colorscheme rose-pine')
    --   end
    -- })

    use({
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          icons = false,
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    })

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use("nvim-treesitter/nvim-treesitter-context")

    use {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} }
    }

    use('mbbill/undotree')

    use('tpope/vim-fugitive')

    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
	    requires = {
		    -- LSP Support
		    {'neovim/nvim-lspconfig'},
		    {'williamboman/mason.nvim'},
		    {'williamboman/mason-lspconfig.nvim'},

		    -- Autocompletion
		    {'hrsh7th/nvim-cmp'},
		    {'hrsh7th/cmp-buffer'},
		    {'hrsh7th/cmp-path'},
		    {'saadparwaiz1/cmp_luasnip'},
		    {'hrsh7th/cmp-nvim-lsp'},
		    {'hrsh7th/cmp-nvim-lua'},

		    -- Snippets
		    {'L3MON4D3/LuaSnip'},
		    {'rafamadriz/friendly-snippets'},
	    }
    }

    use('tpope/vim-commentary')

    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
      'lewis6991/gitsigns.nvim',
    }

    use('fatih/vim-go')

    -- use('folke/flash.nvim')
end)
