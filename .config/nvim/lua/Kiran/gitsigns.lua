local gitsigns = require "gitsigns"

gitsigns.setup {
    signs = {
        add = { text = "🮇" },
        change = { text = "🮇" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = {
            text = "🮇",
        },
    },
}
