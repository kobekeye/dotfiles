vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }


-- keymap('n', '<leader>cv', '<cmd>tcd -<CR>', { desc = "return original directory" })
-- Visual Mode 下縮排後保持選取
keymap('v', '>', '>gv', { desc = "Indent and re-select", unpack(opts) })
keymap('v', '<', '<gv', { desc = "Un-indent and re-select", unpack(opts) })


-- 使用 Ctrl + HJKL 進行視窗導航(Normal Mode)
keymap('n', '<C-h>', '<C-w>h', { desc = '[Ctrl+H] Move Left', unpack(opts) })
keymap('n', '<C-j>', '<C-w>j', { desc = '[Ctrl+J] Move Down', unpack(opts) })
keymap('n', '<C-k>', '<C-w>k', { desc = '[Ctrl+K] Move Up', unpack(opts) })
keymap('n', '<C-l>', '<C-w>l', { desc = '[Ctrl+L] Move Right', unpack(opts) })

-- Terminal Mode 下也支援 Ctrl + HJKL 切窗（需先跳出 terminal 模式）
keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = '[Ctrl+H] Term Move Left', unpack(opts) })
keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = '[Ctrl+J] Term Move Down', unpack(opts) })
keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = '[Ctrl+K] Term Move Up', unpack(opts) })
keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = '[Ctrl+L] Term Move Right', unpack(opts) })

local diagnostic_float_win = nil

vim.keymap.set("n", "<leader>d", function()
  if diagnostic_float_win and vim.api.nvim_win_is_valid(diagnostic_float_win) then
    vim.api.nvim_win_close(diagnostic_float_win, true)
    diagnostic_float_win = nil
    return
  end

  local _, win = vim.diagnostic.open_float(nil, {
    scope = "cursor",
    border = "rounded",
  })

  diagnostic_float_win = win
end, {
  desc = "Toggle line diagnostics",
})
-- 當按下 <Space> + x 時，執行該檔案
vim.keymap.set("n", "<leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("write")

  local file = vim.api.nvim_buf_get_name(0)
  require("lazy.manage.reloader").reload({
    { file = file, what = "changed" },
  })

  vim.notify("Reloaded lazy plugin specs")
end, { desc = "Reload lazy plugin specs" })
vim.api.nvim_create_user_command('Me', 'messages', {})

vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)

  if not filepath:match("%.typ$") then
    vim.notify("OpenPdf only works in Typst files", vim.log.levels.WARN)
    return
  end

  local pdf_path = filepath:gsub("%.typ$", ".pdf")
  vim.system({ "zathura", pdf_path })
end, {})
