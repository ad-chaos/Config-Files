require "nvim-lua.cmp"
require "nvim-lua.treesitter"
require "nvim-lua.gitsigns"
require "nvim-lua.telescope"
require "nvim-lua.plugins"
require "nvim-lua.lsp"
require "nvim-lua.options"
require "nvim-lua.neovide"

vim.cmd [[
augroup overrides
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
vim.g.loaded_matchit=1

if vim.g.neovide then
    vim.keymap.set("n", "<D-v>", "\"+p")
end
-- local ts_utils = require("nvim-treesitter.ts_utils")
-- local node = ts_utils.get_node_at_cursor()
-- local prev_node = ts_utils.get_previous_node(node, true, true)
-- vim.keymap.set("n", "[p", ts_utils.goto_node(prev_node, true, true))
