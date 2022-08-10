require "Kiran.cmp"
require "Kiran.treesitter"
require "Kiran.gitsigns"
require "Kiran.telescope"
require "Kiran.plugins"
require "Kiran.lsp"
require "Kiran.options"
require "Kiran.neovide"

vim.cmd [[
augroup overides
    au!
    au ColorScheme dracula hi SpellBad   gui=undercurl
                       \ | hi SpellCap   gui=undercurl
                       \ | hi SpellRare  gui=undercurl
                       \ | hi SpellLocal gui=undercurl
                       \ | hi link WhiteSpace Directory
augroup END
]]

vim.cmd [[ let g:netrw_banner=0 ]]
vim.cmd [[ colorscheme dracula ]]
