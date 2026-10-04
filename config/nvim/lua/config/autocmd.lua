vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local filetype = vim.bo.filetype
    local two_space = { "html", "css", "javascript", "lua", "typst" }

    if vim.tbl_contains(two_space, filetype) then
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.expandtab = true
    elseif filetype == "go" then
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.expandtab = false
    else
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.expandtab = true
    end
  end,
})

-- autosave
local autosave_group = vim.api.nvim_create_augroup("UserAutoSave", { clear = true })
local autosave_timer = nil
local autosave_saving = false

local function should_autosave(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end

  if not vim.bo[buf].modified then
    return false
  end

  if not vim.bo[buf].modifiable or vim.bo[buf].readonly then
    return false
  end

  if vim.bo[buf].buftype ~= "" then
    return false
  end

  if vim.api.nvim_buf_get_name(buf) == "" then
    return false
  end

  return true
end

local function autosave(buf)
  if autosave_saving or not should_autosave(buf) then
    return
  end

  autosave_saving = true

  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent keepalt update")
  end)

  autosave_saving = false

  vim.notify("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"), vim.log.levels.INFO)
end

local function schedule_autosave()
  local buf = vim.api.nvim_get_current_buf()

  if autosave_timer then
    autosave_timer:stop()
    autosave_timer:close()
  end

  autosave_timer = vim.uv.new_timer()
  autosave_timer:start(135, 0, vim.schedule_wrap(function()
    autosave(buf)
  end))
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "FocusLost" }, {
  group = autosave_group,
  callback = schedule_autosave,
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
