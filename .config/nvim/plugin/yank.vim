augroup LuaHighlight
  au!
  au TextYankPost * lua vim.highlight.on_yank {
        \ higroup = "Visual",
        \ timeout = 150,
        \ on_visual = false
        \ }
augroup END
