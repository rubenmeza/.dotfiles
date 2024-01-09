local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-g>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-z>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-x>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-c>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-v>", function() harpoon:list():select(4) end)
