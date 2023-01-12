require "nvim-lua.cmp"
require "nvim-lua.treesitter"
require "nvim-lua.gitsigns"
require "nvim-lua.telescope"
require "nvim-lua.plugins"
require "nvim-lua.lsp"
require "nvim-lua.options"


if vim.g.neovide then
    require "nvim-lua.neovide"
end

vim.cmd [[autocmd User LspProgressUpdate redrawstatus]]
vim.cmd [[let g:netrw_banner=0]]
vim.cmd [[set statusline=%!v:lua.require'statusline'.statusline()]]

require("tokyonight").setup({
    style = "night",
    on_colors = function(colors)
        colors.bg = "#0d0e12"
        colors.bg_dark = "#0d0e12"
        colors.bg_highlight = "#0d0e12"
      end
})
vim.cmd [[colorscheme tokyonight-night]]
