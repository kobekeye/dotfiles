return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "lua", "python", "bash", "markdown", "typst" }, -- 你常用的語言
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
