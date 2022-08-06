local surround = require "nvim-surround"
surround.buffer_setup {
    surrounds = {
        ["l"] = {
            add = function()
                return {
                    "[",
                    "](" .. vim.fn.getreg "*" .. ")",
                }
            end,
        },
    },
}

vim.cmd "setlocal spell spelllang=en_US"
vim.cmd "setlocal textwidth=120"
vim.cmd "setlocal comments-=fb:- comments+=:-"
vim.cmd "setlocal formatoptions+=ro"
