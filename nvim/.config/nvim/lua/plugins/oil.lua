return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
      -- "permission",
      -- "size",
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit", -- Ctrl+s 垂直分割開啟
      ["<C-h>"] = "actions.select_split",  -- Ctrl+h 水平分割開啟
      ["<C-t>"] = "actions.select_tab",    -- Ctrl+t在新分頁開啟
      ["<C-p>"] = "actions.preview",       -- Ctrl+p 預覽檔案
      ["-"] = "actions.parent",            -- 按 - 回上一層目錄
      ["_"] = "actions.open_cwd",          -- 按 _ 讓 nvim 的 root 切換到當前 oil 目錄
    },
    view_options = {
        
    }
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
