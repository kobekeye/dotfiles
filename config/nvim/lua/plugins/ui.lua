local active_colorscheme = "tokyonight-moon"

local function set_tabline_hl()
  vim.api.nvim_set_hl(0, "TabLine", {
    fg = "#565f89",
    bg = "NONE",
    bold = false,
  })

  vim.api.nvim_set_hl(0, "TabLineSel", {
    fg = "#565f89",
    bg = "NONE",
    bold = false,
  })

  vim.api.nvim_set_hl(0, "TabLineFill", {
    bg = "NONE",
  })
end

return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme(active_colorscheme)
      set_tabline_hl()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_tabline_hl,
      })
    end,
  },

  { "catppuccin/nvim", name = "catppuccin" },
  { "ellisonleao/gruvbox.nvim" },
  { "navarasu/onedark.nvim" },
  { "Mofiqul/vscode.nvim" },
  { "D0nw0r/dark2026.nvim" },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "dracula",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "neo-tree", "opencode" },
        },
        globalstatus = false,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
      },
    },
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    enabled = true,
    lazy = false,
    keys = {
      { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", mode = "n", silent = true, desc = "Next buffer" },
      { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", mode = "n", silent = true, desc = "Previous buffer" },
      {
        "<leader>bt",
        function()
          local bufferline_tabline = "%!v:lua.nvim_bufferline()"

          if vim.o.tabline == bufferline_tabline then
            vim.o.tabline = "" -- 回到原生 tabline
          else
            vim.o.tabline = bufferline_tabline
          end

          vim.o.showtabline = 2
          vim.cmd.redrawtabline()
        end,
        mode = "n",
        desc = "Toggle bufferline",
      },
    },
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        color_icons = true,
        custom_filter = function(bufnr)
          return vim.bo[bufnr].filetype ~= "opencode"
        end,
        close_command = function(bufnr)
          local listed_buffers = vim.tbl_filter(function(buf)
            return buf ~= bufnr and vim.bo[buf].buflisted
          end, vim.api.nvim_list_bufs())

          for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
            if vim.api.nvim_win_is_valid(win) and #listed_buffers > 0 then
              vim.api.nvim_win_set_buf(win, listed_buffers[#listed_buffers])
            end
          end

          vim.cmd("bdelete! " .. bufnr)
        end,
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "",
            text_align = "left",
            separator = true,
          },
        },
      }
    }
  },

  -- Dashboard
  {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-mini/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    config = function ()
        require'alpha'.setup(require'alpha.themes.theta'.config)
    end
  },
  
  -- Command UI / notifications
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      notify = {
        enabled = false,
      },
      lsp = {
        signature = { enabled = false },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000",
          timeout = 2000,
          render = "compact",
          stages = "static",
        },
      },
    },
  },
}
