vim.keymap.set("n", "<leader>-", function()
    local name, ext = unpack(vim.fn.split(vim.fn.expand("%:t") , "\\ze\\."))
    return ":e " .. name .. ((ext == ".hpp") and  ".cpp" or ".hpp") .. "<CR>"
end, { expr = true, buffer = true })
