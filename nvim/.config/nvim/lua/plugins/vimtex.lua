return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- 使用 Zathura 预览
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

    -- 强制 latexmk 用 XeLaTeX 生成 PDF
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-pdf",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      }
    }

    vim.g.vimtex_compiler_latexmk_engines = {
      ['_'] = '-lualatex',
    }
  end,
}

