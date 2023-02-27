require "nvim-lua.cmp"
require "nvim-lua.treesitter"
require "nvim-lua.gitsigns"
require "nvim-lua.telescope"
require "nvim-lua.plugins"
require "nvim-lua.lsp"


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
require("fidget").setup({
    text = {
        spinner = "dots"
    }
})

vim.cmd [[colorscheme tokyonight-night]]

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.vim = {
  install_info = {
    url = "~/git-repos/tree-sitter-viml", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"}
  }
}
