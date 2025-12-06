-- bootstrap of lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

--setup lazy.nvim
require("lazy").setup({
    spec = {
	-- load all plugins from the spec folder
	{ import = "config", lazy = false, priority = 1000 },
	{ import = "plugins" },
    }, 
    -- configure lazy.nvim
    install = {
	colorscheme = { "tokyonight", "habamax" },
    },
    checker = {
	enabled = true,
	notify = false,
    },
    change_detection = {
	notify = false,
    },
})
