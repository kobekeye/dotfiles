-- 建立 ToggleTerm 相關自動指令群組
local toggleterm_augroup = vim.api.nvim_create_augroup('UserToggleTermEnter', { clear = true })

vim.api.nvim_create_autocmd('WinEnter', {
  group = toggleterm_augroup,
  pattern = '*', -- 監聽所有視窗的進入事件
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd('startinsert')
    end
  end,
})

-- local colorscheme_augroup = vim.api.nvim_create_augroup('UserColorschemeSwitch', { clear = true })
--
-- -- .tex 檔案切換 editor 主題為 onedark
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   group = colorscheme_augroup,
--   pattern = "*.tex",
--   callback = function()
--     if vim.bo.buftype == "" then
--       vim.cmd("colorscheme onedark")
--       require('lualine').setup { options = { theme = 'dracula' } }
--     end
--   end,
-- })
--
-- -- 非 .tex 檔案切換 editor 主題為 visual_studio_code
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   group = colorscheme_augroup,
--   pattern = "*",
--   callback = function()
--     if vim.bo.buftype == "" and vim.fn.expand("%:e") ~= "tex" then
--       vim.cmd("colorscheme visual_studio_code")
--       require('lualine').setup { options = { theme = 'dracula' } }
--     end
--   end,
-- })
return {}
