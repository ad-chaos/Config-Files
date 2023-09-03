vim.g.netrw_banner = 0
vim.g.wordmotion_prefix = "\\"
vim.g.mapleader = " "

require("world.plugins")

vim.cmd [[colorscheme tokyonight-night]]
vim.cmd [[set statusline=%!v:lua.require'statusline'.statusline()]]
