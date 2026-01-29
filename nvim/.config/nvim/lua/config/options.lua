vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.splitright = true

vim.opt.clipboard = 'unnamedplus'

-- 用 autocmd 統一管理所有 filetype 的縮排
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local ft = vim.bo.filetype
        local two_space = { "html", "css", "javascript", "lua" }
        
        if vim.tbl_contains(two_space, ft) then
            vim.opt_local.tabstop = 2
            vim.opt_local.shiftwidth = 2
            vim.opt_local.softtabstop = 2
        else
            -- 其他語言用 4
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
        end
    end,
})
-- vim.opt_global.tabstop = 4
-- vim.opt_global.shiftwidth = 4
-- vim.opt_global.softtabstop = 4
-- vim.opt_global.expandtab = true
-- 監控 tabstop 被修改的時機
-- vim.api.nvim_create_autocmd("OptionSet", {
--     pattern = "tabstop",
--     callback = function()
--         vim.notify(
--             "tabstop 被改成: " .. vim.o.tabstop .. "\n" ..
--             "觸發來源: " .. debug.traceback(),
--             vim.log.levels.WARN
--         )
--     end,
-- })
-- Enable break indent
vim.opt.breakindent = true

return{}
