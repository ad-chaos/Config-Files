require "nvim-lua.cmp"
require "nvim-lua.treesitter"
require "nvim-lua.gitsigns"
require "nvim-lua.telescope"
require "nvim-lua.plugins"
require "nvim-lua.lsp"
require "nvim-lua.options"
require "nvim-lua.neovide"

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
