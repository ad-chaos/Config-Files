require("Kiran.options")
require("Kiran.keymaps")
require("Kiran.plugins")
require("Kiran.cmp")
require("Kiran.treesitter")
require("Kiran.telescope")
require("Kiran.lsp")
require("Kiran.gitsigns")
require("Kiran.neovide")

--  Change cursor depending on modes
--  SI is Insert
--  SR is Replace
--  EI is Normal (Else)
-- vim.cmd [[let &t_SI.="\e[6 q"]]
-- vim.cmd [[let &t_SR.="\e[4 q"]]
-- vim.cmd [[let &t_EI.="\e[1 q"]]

-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
vim.cmd([[ set foldmethod=marker ]])
vim.cmd([[ let g:netrw_banner=0 ]])
vim.cmd([[ set fo+=/ ]])
-- Load the colorscheme
vim.cmd([[ colorscheme dracula ]])
