require("nvim-treesitter.configs").setup {
    sync_install = false,
    ensure_installed = { "lua", "python", "cpp", "c", "javascript", "vim", "toml", "markdown" },
    highlight = {
        enable = true,
        disable = { "" },
    },
    -- TODO: Remove python once it is fixed upstream
    indent = { enable = true, disable = { "python" } },
    incremental_selection = { enable = true },
}
