return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      -- 完全關閉 signature help
      signature = { enabled = false },
    },
    -- 你原本的其他設定也放在這裡
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}

