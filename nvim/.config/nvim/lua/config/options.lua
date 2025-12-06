vim.opt.number = true
vim.opt.relativenumber = false


vim.opt.clipboard = 'unnamedplus'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascript" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Enable break indent
vim.opt.breakindent = true

return{}

























