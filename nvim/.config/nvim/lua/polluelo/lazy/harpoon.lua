return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-g>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-z>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-x>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-c>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-v>", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<leader><C-z>", function() harpoon:list():replace_at(1) end)
    vim.keymap.set("n", "<leader><C-x>", function() harpoon:list():replace_at(2) end)
    vim.keymap.set("n", "<leader><C-c>", function() harpoon:list():replace_at(3) end)
    vim.keymap.set("n", "<leader><C-v>", function() harpoon:list():replace_at(4) end)
  end
}
