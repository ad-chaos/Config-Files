if vim.g.nots then
    return
end

require("nvim-treesitter.configs").setup({
    sync_install = false,
    ensure_installed = {
        "c",
        "comment",
        "cpp",
        "css",
        "html",
        "javascript",
        "lua",
        "rust",
        "toml",
        "typescript",
        "vim",
    },
    highlight = {
        enable = true,
    },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = { enable = false },
})
