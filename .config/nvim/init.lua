require "nvim-lua.cmp"
require "nvim-lua.treesitter"
require "nvim-lua.gitsigns"
require "nvim-lua.telescope"
require "nvim-lua.plugins"
require "nvim-lua.lsp"
require "nvim-lua.options"

vim.cmd [[augroup overrides
    au!
    au ColorScheme dracula hi SpellBad   gui=undercurl
                       \ | hi SpellCap   gui=undercurl
                       \ | hi SpellRare  gui=undercurl
                       \ | hi SpellLocal gui=undercurl
augroup END
]]
vim.cmd [[autocmd User LspProgressUpdate redrawstatus]]
vim.cmd [[let g:netrw_banner=0]]
vim.cmd [[colorscheme dracula]]
vim.cmd [[set statusline=%!v:lua.require'statusline'.statusline()]]

if vim.g.neovide then
    require "nvim-lua.neovide"
end
