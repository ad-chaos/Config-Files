local surround = require "nvim-surround"

surround.buffer_setup({
    surrounds = {
        l = {
            add = function()
                local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                return {
                    { "[" },
                    { "](" .. clipboard .. ")" },
                }
            end,
            find = "%b[]%b()",
            delete = "^(%[)().-(%]%b())()$",
            change = {
                target = "^()()%b[]%((.-)()%)$",
                replacement = function()
                    local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                    return {
                        { "" },
                        { clipboard },
                    }
                end,
            },
        },
    },
})

vim.cmd "setlocal spell spelllang=en_US"
vim.cmd "setlocal textwidth=120"
vim.cmd "setlocal comments-=fb:- comments+=:-"
vim.cmd "setlocal formatoptions+=ro"
