return {
    "uga-rosa/ccc.nvim",
    config = function()
        local ccc = require("ccc")
        ccc.setup({
            -- 這裡可以設定預設顏色格式 (Hex, RGB, HSL 等)
            highlighter = {
                auto_enable = true, -- 開啟檔案時自動顯示顏色
                lsp = true,         -- 支援 LSP
            },
        })
    end,
}

