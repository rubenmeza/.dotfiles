return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>wk",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Show all keybindings",
    },
  },
}
