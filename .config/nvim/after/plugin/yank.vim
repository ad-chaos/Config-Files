augroup LuaHighlight
  au!
  au TextYankPost * lua vim.highlight.on_yank {
        \ higroup = "Visual",
        \ timeout = 400,
        \ on_macro = true
        \ }
augroup END
