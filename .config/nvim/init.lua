require "nvim-lua.cmp"
require "nvim-lua.treesitter"
require "nvim-lua.plugins"
require "nvim-lua.lsp"


if vim.g.neovide then
    require "nvim-lua.neovide"
end

vim.cmd [[autocmd User LspProgressUpdate redrawstatus]]
vim.cmd [[let g:netrw_banner=0]]
vim.cmd [[set statusline=%!v:lua.require'statusline'.statusline()]]

local telescope = require("telescope")
local action_layout = require "telescope.actions.layout"

telescope.setup({
    defaults = {
        prompt_prefix = "  ",
        selection_caret = "  ",
        mappings = {
            i = {
                ["?"] = action_layout.toggle_preview,
            },
        },
    },
})
telescope.load_extension "fzf"

require("gitsigns").setup({
    signs = {
        add = { text = "🮇" },
        change = { text = "🮇" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = {
            text = "🮇",
        },
    },
})

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
