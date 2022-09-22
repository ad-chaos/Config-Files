require("nvim-treesitter.configs").setup {
    sync_install = false,
    ensure_installed = { "lua", "python", "cpp", "c", "javascript", "toml", "markdown", "rust", "comment"},
    highlight = {
        enable = true,
        disable = { "" },
    },
    -- TODO: Remove python once it is fixed upstream
    indent = { enable = true, disable = { "python" } },
    incremental_selection = { enable = true, disable = { "" } },
}
