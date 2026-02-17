return {
--   {
--     'olimorris/codecompanion.nvim',
--     config = function()
--       require('codecompanion').setup {
--         adapters = {
--           copilot = function()
--             return require('codecompanion.adapters').extend('copilot', {
--               schema = {
--                 model = {
--                   default = 'claude-3.5-sonnet',
--                 },
--               },
--             })
--           end,
--         },
--         strategies = {
--           chat = {
--             adapter = 'copilot',
--             roles = { llm = "Claude", user = "You" },
--             variables = {
--               ["buffer"] = {
--                 callback = function(context)
--                   return context.bufnr and vim.api.nvim_buf_get_lines(context.bufnr, 0, -1, false) or {}
--                 end,
--               },
--               ["go_module"] = {
--                 callback = function()
--                   local result = vim.fn.system("go list -m 2>/dev/null")
--                   return vim.v.shell_error == 0 and vim.trim(result) or "unknown"
--                 end,
--               },
--               ["go_package"] = {
--                 callback = function()
--                   local result = vim.fn.system("go list . 2>/dev/null")
--                   return vim.v.shell_error == 0 and vim.trim(result) or "unknown"
--                 end,
--               },
--               ["project_root"] = {
--                 callback = function()
--                   return vim.fn.getcwd()
--                 end,
--               },
--             },
--           },
--           inline = {
--             adapter = 'copilot',
--           },
--           agent = {
--             adapter = 'copilot',
--             tools = {
--               "code_runner",
--               "editor",
--             },
--           },
--         },
--         display = {
--           chat = {
--             window = {
--               layout = 'float',
--               width = 0.85,
--               height = 0.85,
--               border = 'rounded',
--             },
--           },
--           diff = {
--             enabled = true,
--             close_chat_at = 240,
--             provider = 'mini_diff',
--           },
--         },
--         prompt_library = {
--           ["Go Review"] = {
--             strategy = "chat",
--             description = "Review Go code with monorepo best practices",
--             opts = {
--               mapping = "<leader>cr",
--               modes = { "v" },
--               slash_cmd = "review",
--               auto_submit = false,
--             },
--             prompts = {
--               {
--                 role = "system",
--                 content = [[You are a senior Go developer reviewing code in a monorepo. Focus on:

-- **Code Quality:**
-- - Go idioms and best practices
-- - Error handling patterns
-- - Interface design and usage
-- - Struct composition vs inheritance

-- **Monorepo Considerations:**
-- - Package boundaries and responsibilities
-- - Import cycles and dependency management
-- - Shared code patterns and reusability
-- - API consistency across packages

-- **Performance & Concurrency:**
-- - Memory allocations and GC pressure
-- - Goroutine usage and channel patterns
-- - Context propagation and cancellation
-- - Resource cleanup and lifecycle management

-- Module: {{{ go_module }}}
-- Package: {{{ go_package }}}

-- Provide specific, actionable feedback with examples.]],
--               },
--               {
--                 role = "user",
--                 content = "Review this Go code:\n\n```go\n{{{ selection }}}\n```",
--               },
--             },
--           },
--           ["Go Test"] = {
--             strategy = "inline",
--             description = "Generate comprehensive Go tests",
--             opts = {
--               mapping = "<leader>ct",
--               modes = { "v" },
--               slash_cmd = "test",
--             },
--             prompts = {
--               {
--                 role = "system",
--                 content = [[Generate comprehensive Go tests including:

-- 1. **Table-driven tests** with descriptive test cases
-- 2. **Edge cases** and error conditions
-- 3. **Mock dependencies** using interfaces
-- 4. **Subtests** for logical grouping
-- 5. **Benchmark tests** for performance validation
-- 6. **Integration tests** when appropriate

-- Use testify/assert for assertions and follow Go testing conventions.
-- Module: {{{ go_module }}}
-- Package: {{{ go_package }}}]],
--               },
--               {
--                 role = "user",
--                 content = "Generate tests for:\n\n```go\n{{{ selection }}}\n```",
--               },
--             },
--           },
--           ["Go Refactor"] = {
--             strategy = "chat",
--             description = "Refactor Go code with architectural improvements",
--             opts = {
--               mapping = "<leader>cR",
--               modes = { "v" },
--               slash_cmd = "refactor",
--             },
--             prompts = {
--               {
--                 role = "system",
--                 content = [[Analyze and suggest refactoring improvements for:

-- **Structure & Design:**
-- - Code organization and modularity
-- - Interface extraction and composition
-- - Dependency injection patterns
-- - SOLID principles application

-- **Monorepo Patterns:**
-- - Package boundaries and cohesion
-- - Shared utilities and common patterns
-- - API consistency and versioning
-- - Build and deployment considerations

-- **Performance & Maintainability:**
-- - Algorithm optimizations
-- - Memory usage improvements
-- - Concurrent programming patterns
-- - Error handling consistency

-- Module: {{{ go_module }}}
-- Package: {{{ go_package }}}

-- Provide before/after examples with clear explanations.]],
--               },
--               {
--                 role = "user",
--                 content = "Refactor this Go code:\n\n```go\n{{{ selection }}}\n```",
--               },
--             },
--           },
--           ["Go Debug"] = {
--             strategy = "chat",
--             description = "Debug Go code issues and problems",
--             opts = {
--               mapping = "<leader>cd",
--               modes = { "v" },
--               slash_cmd = "debug",
--             },
--             prompts = {
--               {
--                 role = "system",
--                 content = [[Help debug Go code by analyzing:

-- **Common Issues:**
-- - Race conditions and data races
-- - Memory leaks and goroutine leaks
-- - Deadlocks and channel misuse
-- - Panic conditions and recovery

-- **Debugging Techniques:**
-- - Adding logging and instrumentation
-- - Using Go's built-in debugging tools
-- - Profiling and performance analysis
-- - Test-driven debugging approaches

-- **Monorepo Debugging:**
-- - Cross-package dependency issues
-- - Build and module problems
-- - Integration test failures
-- - Service communication problems

-- Module: {{{ go_module }}}
-- Package: {{{ go_package }}}

-- Provide debugging steps and preventive measures.]],
--               },
--               {
--                 role = "user",
--                 content = "Debug this Go code:\n\n```go\n{{{ selection }}}\n```",
--               },
--             },
--           },
--           ["Go Optimize"] = {
--             strategy = "chat",
--             description = "Optimize Go code for performance",
--             opts = {
--               mapping = "<leader>co",
--               modes = { "v" },
--               slash_cmd = "optimize",
--             },
--             prompts = {
--               {
--                 role = "system",
--                 content = [[Analyze and optimize Go code for:

-- **Performance:**
-- - Memory allocation reduction
-- - CPU usage optimization
-- - I/O operation efficiency
-- - Concurrent processing improvements

-- **Scalability:**
-- - Connection pooling and reuse
-- - Caching strategies
-- - Batch processing patterns
-- - Load balancing considerations

-- **Profiling Guidance:**
-- - CPU profiling techniques
-- - Memory profiling analysis
-- - Goroutine profiling insights
-- - Benchmark writing and interpretation

-- Module: {{{ go_module }}}
-- Package: {{{ go_package }}}

-- Provide specific optimizations with benchmarking suggestions.]],
--               },
--               {
--                 role = "user",
--                 content = "Optimize this Go code:\n\n```go\n{{{ selection }}}\n```",
--               },
--             },
--           },
--           ["Go Architecture"] = {
--             strategy = "chat",
--             description = "Architectural guidance for Go systems",
--             opts = {
--               mapping = "<leader>cA",
--               modes = { "n", "v" },
--               slash_cmd = "arch",
--             },
--             prompts = {
--               {
--                 role = "system",
--                 content = [[Provide architectural guidance for Go systems:

-- **System Design:**
-- - Package structure and organization
-- - Service boundaries and communication
-- - Data flow and state management
-- - Error propagation and handling

-- **Monorepo Architecture:**
-- - Module boundaries and dependencies
-- - Shared libraries and common patterns
-- - Build system and CI/CD considerations
-- - Team collaboration and ownership

-- **Scalability & Reliability:**
-- - Distributed system patterns
-- - Fault tolerance and resilience
-- - Monitoring and observability
-- - Performance and capacity planning

-- Module: {{{ go_module }}}
-- Package: {{{ go_package }}}
-- Project: {{{ project_root }}}

-- Focus on practical, implementable solutions.]],
--               },
--               {
--                 role = "user",
--                 content = "Provide architectural guidance for: {{{ selection }}}",
--               },
--             },
--           },
--           ["Go Generate"] = {
--             strategy = "inline",
--             description = "Generate Go code patterns and boilerplate",
--             opts = {
--               mapping = "<leader>cg",
--               modes = { "n", "v" },
--               slash_cmd = "generate",
--             },
--             prompts = {
--               {
--                 role = "system",
--                 content = [[Generate Go code following these patterns:

-- **Code Generation:**
-- - Interface implementations
-- - Struct methods and constructors
-- - Error types and handling
-- - Configuration and options patterns

-- **Monorepo Patterns:**
-- - Package initialization
-- - Common utilities and helpers
-- - API client and server patterns
-- - Testing utilities and fixtures

-- **Best Practices:**
-- - Proper documentation comments
-- - Error handling patterns
-- - Context usage and propagation
-- - Resource cleanup and defer patterns

-- Module: {{{ go_module }}}
-- Package: {{{ go_package }}}

-- Generate clean, idiomatic Go code.]],
--               },
--               {
--                 role = "user",
--                 content = "Generate Go code for: {{{ selection }}}",
--               },
--             },
--           },
--         },
--       }
--       -- Expand 'cc' into 'CodeCompanion' in the command line
--       vim.cmd [[cab cc CodeCompanion]]
--     end,
--     keys = {
--       -- Core functionality
--       { '<leader>ca', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Actions List' },
--       { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Toggle Chat' },
--       { '<leader>cca', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', noremap = true, silent = true, desc = 'Add to Chat' },
--       { '<leader>ci', '<cmd>CodeCompanion<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Inline Prompt' },

--       -- Go-specific workflows
--       { '<leader>cr', '<cmd>CodeCompanion Go Review<cr>', mode = 'v', noremap = true, silent = true, desc = 'Go Code Review' },
--       { '<leader>ct', '<cmd>CodeCompanion Go Test<cr>', mode = 'v', noremap = true, silent = true, desc = 'Generate Go Tests' },
--       { '<leader>cR', '<cmd>CodeCompanion Go Refactor<cr>', mode = 'v', noremap = true, silent = true, desc = 'Refactor Go Code' },
--       { '<leader>cd', '<cmd>CodeCompanion Go Debug<cr>', mode = 'v', noremap = true, silent = true, desc = 'Debug Go Code' },
--       { '<leader>co', '<cmd>CodeCompanion Go Optimize<cr>', mode = 'v', noremap = true, silent = true, desc = 'Optimize Go Code' },
--       { '<leader>cA', '<cmd>CodeCompanion Go Architecture<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Go Architecture' },
--       { '<leader>cg', '<cmd>CodeCompanion Go Generate<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Generate Go Code' },

--       -- Quick access to slash commands in chat
--       { '<leader>c/', '<cmd>CodeCompanionChat<cr>/', mode = 'n', noremap = true, silent = true, desc = 'Chat with Slash Command' },
--     },
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       'nvim-treesitter/nvim-treesitter',
--     },
--   },
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
    'AndreM222/copilot-lualine',
  },
  {
    "sudo-tee/opencode.nvim",
    config = function()
      require("opencode").setup({})
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { 'markdown', 'opencode_output' },
        },
        ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
      },
      -- Optional, for file mentions and commands completion, pick only one
      'saghen/blink.cmp',
      -- 'hrsh7th/nvim-cmp',

      -- Optional, for file mentions picker, pick only one
      'folke/snacks.nvim',
      -- 'nvim-telescope/telescope.nvim',
      -- 'ibhagwan/fzf-lua',
      -- 'nvim_mini/mini.nvim',
    },
  }
}
-- return {
  -- {
  --   'zbirenbaum/copilot.lua',
  --   config = function ()
  --     local copilot  = require('copilot')
  --     local suggestion = require('copilot.suggestion')

  --     copilot.setup {
  --       suggestion = {
  --         auto_trigger = true
  --       },
  --       filetypes = {
  --         ["*"] = true,
  --       },
  --     }

  --     vim.keymap.set('i', '<Tab>', function()
  --       if suggestion.is_visible() then
  --         suggestion.accept()
  --       else
  --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  --       end
  --     end, { desc = "Super Tab" })
  --   end
  -- },
  -- {
  --   'AndreM222/copilot-lualine',
  -- },
  -- {
  --   'olimorris/codecompanion.nvim',
  --   config = function()
  --     require('codecompanion').setup {
  --       adapters = {
  --         copilot = function()
  --           return require('codecompanion.adapters').extend('copilot', {
  --             schema = {
  --               model = {
  --                 default = 'claude-3.7-sonnet',
  --               },
  --             },
  --           })
  --         end,
  --       },
  --       strategies = {
  --         chat = {
  --           adapter = 'copilot',
  --         },
  --         inline = {
  --           adapter = 'copilot',
  --         },
  --       },
  --       display = {
  --         chat = {
  --           window = {
  --             layout = 'float',
  --           },
  --         },
  --         diff = {
  --           enabled = true,
  --           close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
  --           provider = 'mini_diff', -- default|mini_diff
  --         },
  --       },
  --     }

  --     -- Expand 'cc' into 'CodeCompanion' in the command line
  --     vim.cmd [[cab cc CodeCompanion]]
  --   end,
  --   keys = {
  --     { '<leader>ca', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Actions List' },
  --     { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Toggle Chat Window' },
  --     { '<leader>cca', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', noremap = true, silent = true, desc = 'Add to Chat' },
  --     { '<leader>ci', '<cmd>CodeCompanion<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = 'Inline Prompt' },
  --   },
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  -- },
-- }
