local telescope = require "telescope"

telescope.setup {
    defaults = {
        prompt_prefix = "  ",
        selection_caret = "  ",
    },
}
telescope.load_extension "fzf"
