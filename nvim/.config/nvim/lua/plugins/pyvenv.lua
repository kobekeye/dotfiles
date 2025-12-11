return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    -- 您的選項，例如 name = "venv" 或 "v.env"
    name = { "venv", ".venv" }, 
    -- 讓 pyright 或 pylsp 自動重新載入
    dap_enabled = true,
  },
  keys = {
    -- 設定快捷鍵，例如 <Leader>vs 來開啟選單
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
  },
}
