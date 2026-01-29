return {
  -- 核心：LSP 設定
  -- 核心：LSP 設定
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = { -- 只顯示 Warning (警告) 以上的訊息 (包含 Error)
          -- 這會自動過濾掉 Hint (綠色) 和 Info (藍色/淡藍色)
          severity = { min = vim.diagnostic.severity.WARN },
        },
        signs = {
          severity = { min = vim.diagnostic.severity.WARN },
        },         -- 左側顯示圖標 (E, W, H)
        underline = true,     -- 錯誤下方底線
        update_in_insert = false, -- 輸入時不更新，避免閃爍
        severity_sort = true, -- 嚴重的錯誤排在前面
      })
      local on_attach = function(client, bufnr)
        -- 您可以在這裡設定 LSP 相關的快捷鍵
        -- 例如：vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      end

      -- ‼️ 注意：這裡需要先載入 nvim-cmp，所以要確保它的設定也在
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")

      -- ✅ 使用新的 setup API
      require("mason-lspconfig").setup({
        handlers = {
          -- 預設 handler
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
          -- lua_ls 的額外設定
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  workspace = { checkThirdParty = false },
                },
              },
            })
          end,
        }
      })
    end,
  },

  -- LSP 安裝器
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- 確保這些 LSP Server 會被自動安裝
      ensure_installed = {
        "clangd",
        "pyright",
        "lua_ls",
        "gopls",
        "rust_analyzer",
        "bashls",
        "html",
        "cssls",
        "ts_ls",
        "jsonls",
      },
    },
  },

  -- 🔥 核心：補全引擎 nvim-cmp 🔥
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- 在進入插入模式時才載入
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP 來源
      "hrsh7th/cmp-buffer",   -- Buffer 來源
      "hrsh7th/cmp-path",     -- 路徑來源
      "saadparwaiz1/cmp_luasnip", -- Snippet 來源 (重要的橋樑)
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- 快捷鍵綁定
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 按下 Enter 確認選中的項目
        }),
        -- 補全來源
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- 🔥 核心：片段引擎 Luasnip 🔥
  {
    "L3MON4D3/luasnip",
    version = "v2.*",
    dependencies = {
        -- (可選) 加入常用片段庫
        "rafamadriz/friendly-snippets",
    },
    config = function()
        -- (可選) 載入 friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()
    end
  },

  -- 小工具：自動括號
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

{
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- 使用預設設定
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
},

{
  "folke/lazydev.nvim",
  ft = "lua", -- 只有打開 lua 檔案時才載入，節省資源
  opts = {
    library = {
      -- 讓 lazydev 也支援 lazy.nvim 的全域設定補全
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
},
}

 
