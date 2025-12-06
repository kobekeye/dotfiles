return {
  'akinsho/toggleterm.nvim',
  version = "*", -- 或是指定的版本
  config = function()
    require('toggleterm').setup({
      -- 將設定放在這裡
      open_mapping = [[<c-_>]],
      direction = 'float', -- 推薦使用浮動視窗
      size = 9,
      on_open = function(term)
        -- 'setlocal' 表示只對這個視窗生效，不影響其他程式碼視窗
        -- 'nonumber' 和 'norelativenumber' 分別關閉絕對和相對行號
        vim.cmd('setlocal nonumber norelativenumber')
        -- 【新增這行】設定游標為不閃爍的區塊 (block)
        -- vim.cmd('setlocal guicursor=a:block')
      end,
      -- 進入終-端機時自動進入 Insert mode
      -- start_in_insert = true,
      -- -- 當你離開終端機時，它會保持在 Normal mode
      -- -- 這可以避免你不小心在編輯器中輸入 'i' 或 'a'
      -- persist_mode = false, 
      -- -- 其他你想要的設定...
    })
vim.keymap.set({'n', 't'}, '<C-/>', '<cmd>ToggleTerm<cr>', {noremap = true, silent = true})
  end,
}
