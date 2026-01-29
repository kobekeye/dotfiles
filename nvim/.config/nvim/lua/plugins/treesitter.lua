return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
    },
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local treesitter = require('nvim-treesitter')
        treesitter.install({
            'c',
            'cpp',
            'lua',
            'meson',
            'python',
            'vim',
            'vimdoc',
            'go',
            'rust',
            'typst',
            'latex',
            'typescript',
            'css',
            'bash',
            'markdown',
            'json',
        })
    end,
}
