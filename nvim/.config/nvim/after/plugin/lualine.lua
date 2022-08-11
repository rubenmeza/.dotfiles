local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'dracula',
    component_separators = { left = '►', right = '◄'},
    section_separators = { left = 'ᐳ', right = 'ᐸ'},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    -- ignore_focus = {},
    -- always_divide_middle = true,
    -- globalstatus = false,
    -- refresh = {
    --   statusline = 1000,
    --   tabline = 1000,
    --   winbar = 1000,
    -- }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', { 'diagnostics', sources={ 'nvim_diagnostic' }}},
    lualine_c = { {'filename', file_status=true } },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { 'fugitive' }
}
