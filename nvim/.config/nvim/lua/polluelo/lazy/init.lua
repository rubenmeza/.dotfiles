return {
  {
    "nvim-lua/plenary.nvim",
    name = "plenary"
  },
  {
    'tpope/vim-commentary'
  },
  {
    'AndreM222/copilot-lualine',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = false,
  },
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    lazy = false,
    config = function()
      require('nvim-treesitter.configs').setup {
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
        },
      }
    end
  }
}
