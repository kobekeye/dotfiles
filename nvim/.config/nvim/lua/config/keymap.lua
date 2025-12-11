-- print("hihihihihihi")


vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Visual Mode 下縮排後保持選取
keymap('v', '>', '>gv', { desc = "Indent and re-select", unpack(opts) })
keymap('v', '<', '<gv', { desc = "Un-indent and re-select", unpack(opts) })

-- 使用 Ctrl + HJKL 進行視窗導航（Normal Mode）
keymap('n', '<C-h>', '<C-w>h', { desc = '[Ctrl+H] Move Left', unpack(opts) })
keymap('n', '<C-j>', '<C-w>j', { desc = '[Ctrl+J] Move Down', unpack(opts) })
keymap('n', '<C-k>', '<C-w>k', { desc = '[Ctrl+K] Move Up', unpack(opts) })
keymap('n', '<C-l>', '<C-w>l', { desc = '[Ctrl+L] Move Right', unpack(opts) })

-- Terminal Mode 下也支援 Ctrl + HJKL 切窗（需先跳出 terminal 模式）
keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = '[Ctrl+H] Term Move Left', unpack(opts) })
keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = '[Ctrl+J] Term Move Down', unpack(opts) })
keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = '[Ctrl+K] Term Move Up', unpack(opts) })
keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = '[Ctrl+L] Term Move Right', unpack(opts) })

return {}

