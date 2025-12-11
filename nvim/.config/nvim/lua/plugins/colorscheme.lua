-- lazy
return {
    {
        "Mofiqul/vscode.nvim",
        priority = 110,
        config = function ()
            -- vim.cmd([[colorscheme vscode]])
            -- require('vscode').setup({
            --     terminal_colors = false,
            -- })
        end
    },

    {
        "askfiy/visual_studio_code",
        priority = 100,
        config = function()
            -- vim.cmd([[colorscheme visual_studio_code]])
        end,
    },

    {
        "folke/tokyonight.nvim",
        priority = 70,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 80,
        config = function()
            -- vim.cmd([[colorscheme catppuccin]])
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        priority = 90,
        config = function()
            -- 註解掉這行代表預設不啟用
            -- vim.cmd([[colorscheme gruvbox]])
        end,
    },

    {
        "navarasu/onedark.nvim",
        priority = 60,
        config = function()
            -- vim.cmd([[colorscheme onedark]])
        end,
    },
}
