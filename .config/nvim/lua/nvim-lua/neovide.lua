vim.g.gui_font_default_size = 17.5
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "JetBrains Mono"

RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
end

ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "i" }, "<C-+>", function()
    ResizeGuiFont(1)
end, opts)
vim.keymap.set({ "n", "i" }, "<C-->", function()
    ResizeGuiFont(-1)
end, opts)
vim.keymap.set({ "n", "i" }, "<C-BS>", function()
    ResetGuiFont()
end, opts)

vim.keymap.set("n", "<D-v>", "\"+p")
vim.cmd [[let g:neovide_refresh_rate=100]]
vim.cmd [[let g:neovide_refresh_rate=100]]
vim.cmd [[let g:neovide_remember_window_size = v:true]]
