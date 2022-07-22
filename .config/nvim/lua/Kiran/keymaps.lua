-- Key maps --
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--  Terminal mode mappings
--  Have <Esc> mapped to intuitiveness
keymap("t", ",q", "<C-\\><C-n>", opts)

--  Normal Mode mappings {{{
keymap("n", "<leader>ff", "<cmd>Telescope find_files hidden=true <CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>rr", '<cmd>Gitsigns reset_hunk<CR>', opts)
keymap("n", "<leader>re", '<cmd>Gitsigns reset_buffer<CR>', opts)
keymap("n", "<leader>a", ":Lex 30<CR>", opts)
keymap("n", "%", "g%", opts)
-- keymap("n", "<leader>o", ":e <C-R>=expand('%:p:h') .. '/' <CR>", opts)
-- not using lua api because it is not responsive
vim.cmd[[nnoremap <leader>o :e <C-R>=expand('%:p:h')..'/'<CR>]]
keymap("n", "<leader>u", "g~w", opts)
keymap("n", "<leader>fm", ":Neoformat<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>Y", '"+y$', opts)
keymap("n", "<leader>yy", '"+yy', opts)
keymap("n", "<leader><C-k>", ":resize -4<CR>", opts)
keymap("n", "<leader><C-j>", ":resize +4<CR>", opts)
keymap("n", "<leader><C-h>", ":vertical resize -4<CR>", opts)
keymap("n", "<leader><C-l>", ":vertical resize +4<CR>", opts)
keymap("n", "<C-n>", ":noh<CR>", opts)
keymap("n", "vs", ":vs<CR>", opts)
-- }}}

-- Visual Mode mappings {{{
keymap("v", "<leader>i", "1g<C-a>", opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("v", "J", ":m '>+1<CR>gv", opts)
keymap("v", "K", ":m '<-2<CR>gv", opts)
keymap("v", "p", '"_dP', opts)
keymap("v", "//", "y/\\V<C-R>=escape(@\",'/')<CR><CR>", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
-- }}}

-- Insert Mode Mappings
keymap("i", "<C-p>", "copilot#Accept(\"<CR>\")", {silent = true, script = true, expr = true})
