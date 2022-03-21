require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    sync_install = false,
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true },
})
