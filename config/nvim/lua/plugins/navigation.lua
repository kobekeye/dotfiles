return {
  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim', 
    version = '*',
    dependencies = {
    'nvim-lua/plenary.nvim',
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
    {
      "<leader>vc",
      function()
        local config_dir = vim.fn.stdpath("config")
        require("telescope.builtin").find_files({ cwd = config_dir })
      end,
      desc = "Find Neovim config files",
    },
    {
      "<leader>fa",
      function()
        require("telescope.builtin").find_files({
          search_dirs = {
            vim.fn.expand("~/.config"),
            vim.fn.expand("~/dotfiles"),
          },
          hidden = true,
          path_display = { "truncate" },
        })
      end,
      desc = "Find config and dotfiles",
    },
    },
    opts = {
    pickers = {
      find_files = {
        theme = "ivy",
      },
    },
    },
  }, 
    

  -- File explorer
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    lazy = false,
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    keys = {
    { "-", "<cmd>Oil --float<cr>", desc = "Open parent directory" },
    {
      "<leader>cf",
      function()
        require("oil").open_float(vim.fn.stdpath("config") .. "/lua/plugins/")
      end,
      desc = "Open plugin config directory",
    },
    },
    opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    columns = {
      "icon",
      -- "permission",
      -- "size",
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["q"] = { "actions.close", mode = "n" },
      ["<C-s>"] = "actions.select_vsplit", -- Ctrl+s 垂直分割開啟
      ["<C-h>"] = "actions.select_split",  -- Ctrl+h 水平分割開啟
      ["<C-t>"] = "actions.select_tab",    -- Ctrl+t在新分頁開啟
      ["<C-p>"] = "actions.preview",       -- Ctrl+p 預覽檔案
      ["-"] = "actions.parent",            -- 按 - 回上一層目錄
      ["_"] = "actions.open_cwd",          -- 按 _ 讓 nvim 的 root 切換到當前 oil 目錄
    },
    view_options = {
        show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 0.6,   -- 視窗寬度佔螢幕 60%
      max_height = 0.7,  -- 視窗高度佔螢幕 70%
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    },
    -- Optional dependencies
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  },

  -- tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
    },
    keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }, 
  
  -- neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      {
        "<leader>e",
        "<cmd>Neotree toggle filesystem left reveal_force_cwd<CR>",
        desc = "Toggle Neo-tree at current file",
      },
    },
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        }
      },
      window = {
        position = "left",
        width = 30,
      },
      default_component_configs = {
        indent = {
          padding = 3,
        },
      }
    },
  },

  -- Diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    enabled = true,
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics",
      },
    },
  },
}
