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
    },
    current_line_blame = true
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

require("diffview").setup({
    merge_tool = {
        layout = "diff4_mixed"
    },
    file_panel = {
      win_config = {                      -- See |diffview-config-win_config|
        position = "left",
        width = 25,
        win_opts = {},
      },
    }
})

vim.cmd [[colorscheme tokyonight-night]]
vim.g.wordmotion_prefix = "\\"
