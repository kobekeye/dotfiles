return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- 1. 解決 "overwritten" 錯誤：告訴 Noice 不要搶通知功能
    notify = {
      enabled = false,
    },
    
    -- 2. 你原本的 LSP 設定
    lsp = {
      signature = { enabled = false },
    },
  },
  
  dependencies = {
    "MunifTanjim/nui.nvim",
    
    -- 3. 解決 "background_colour" 錯誤：
    -- 把原本只有一行字串的 notify 改成表格，並加入設定
    {
      "rcarriga/nvim-notify",
      opts = {
        background_colour = "#000000", -- 在這裡指定顏色 (黑色)
      },
    },
  },
}
