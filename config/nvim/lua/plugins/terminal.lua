return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-_>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle terminal" },
    { "<C-/>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle terminal" },
    { "<C-g>", "<C-\\><C-n>", mode = "t", desc = "Terminal normal mode" },
  },
  opts = {
    -- open_mapping = [[<C-_>]],
    direction = "float",
    size = 9,
    on_open = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local group = vim.api.nvim_create_augroup("UserToggleTermEnter", { clear = true })

    vim.api.nvim_create_autocmd("WinEnter", {
      group = group,
      callback = function()
        if vim.bo.buftype == "terminal" then
          vim.cmd.startinsert()
        end
      end,
    })
  end,
}
