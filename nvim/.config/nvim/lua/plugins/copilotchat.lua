return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    keys = {
        { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "CopilotChat - Toggle" },
    },
    opts = {
      -- See Configuration section for options
        
          model = 'gpt-4.1',           -- AI model to use
          temperature = 0.1,           -- Lower = focused, higher = creative
          window = {
            layout = 'vertical',
            width = 0.3, -- Fixed width in columns
            -- height = 20, -- Fixed height in rows
            border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
            title = '🤖 AI Assistant',
            -- zindex = 100, -- Ensure window stays on top
          },
          auto_insert_mode = true,     -- Enter insert mode when opening
          headers = {
            user = '👤 You',
            assistant = '🤖 Copilot',
            tool = '🔧 Tool',
          },

          separator = '━━',
          auto_fold = true, -- Automatically folds non-assistant messages
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      -- 設定針對 copilot buffer 的外觀
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
          vim.opt_local.conceallevel = 0
        end,
      })
    end,

    
  },
}
