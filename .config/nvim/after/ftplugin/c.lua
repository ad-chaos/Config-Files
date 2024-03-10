vim.keymap.set("n", "<leader>fm", function()
    vim.system({'clang-format', '-i', vim.fn.bufname()})
    vim.cmd.normal([[g`"]])
end
)
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autochdir = false
