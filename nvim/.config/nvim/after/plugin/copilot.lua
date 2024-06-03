local copilot  = require('copilot')
local suggestion = require('copilot.suggestion')

copilot.setup {
  suggestion = {
    auto_trigger = true
  },
  filetypes = {
    ["*"] = true,
  },
}

vim.keymap.set('i', '<Tab>', function()
  if suggestion.is_visible() then
    suggestion.accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { desc = "Super Tab" })
