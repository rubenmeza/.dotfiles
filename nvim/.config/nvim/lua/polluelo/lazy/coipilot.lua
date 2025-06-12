return {
  {
    'zbirenbaum/copilot.lua',
    config = function ()
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
    end
  },
  {
    'olimorris/codecompanion.nvim',
    config = function()
      require('codecompanion').setup {
        adapters = {
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'claude-3.7-sonnet',
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'copilot',
          },
          inline = {
            adapter = 'copilot',
          },
        },
        display = {
          chat = {
            window = {
              layout = 'float',
            },
          },
          diff = {
            enabled = true,
            close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
            provider = 'mini_diff', -- default|mini_diff
          },
        },
      }

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
    keys = {
      { '<leader>al', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Actions List' },
      { '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Toggle Chat Window' },
      { '<leader>ag', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', noremap = true, silent = true, desc = 'Add to Chat' },
      { '<leader>ap', '<cmd>CodeCompanion<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Inline Prompt' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
