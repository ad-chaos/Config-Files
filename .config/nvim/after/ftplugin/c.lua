vim.keymap.set("n", "<leader>-", function()
    local name, ext = unpack(vim.fn.split(vim.fn.expand("%:t") , "\\ze\\."))
    return ":e " .. name .. ((ext == ".h") and  ".c" or ".h") .. "<CR>"
end, { expr = true, buffer = true })
