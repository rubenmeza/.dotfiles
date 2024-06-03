require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' },
  },
}
