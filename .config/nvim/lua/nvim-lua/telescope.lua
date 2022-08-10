local telescope = require "telescope"
local action_layout = require "telescope.actions.layout"

telescope.setup {
    defaults = {
        prompt_prefix = "  ",
        selection_caret = "  ",
        mappings = {
            i = {
                ["?"] = action_layout.toggle_preview,
            },
        },
    },
}
telescope.load_extension "fzf"
