return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_x = {
          {
            'copilot',
            show_colors = true,
            show_loading = true
          },
          'encoding',
          'fileformat',
          'filetype'
        },
      },
    }
  end
}
