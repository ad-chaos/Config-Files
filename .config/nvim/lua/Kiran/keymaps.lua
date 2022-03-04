-- Key maps --
local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--  Terminal mode mappings
--  Have <Esc> mapped to intuitiveness
keymap("t", ",q", "<C-\\><C-n>", opts)

--  Normal Mode mappings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>" ,opts)
keymap("n", "<leader>fg","<cmd>Telescope live_grep<CR>",opts)
keymap("n", "<leader>fb","<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh","<cmd>Telescope help_tags<CR>",opts)
keymap("n", "<leader>a", ":Lex 30<CR>", opts)
keymap("n", "<C-k>", ":resize -2<CR>", opts)
keymap("n", "<C-j>", ":resize +2<CR>", opts)
keymap("n", "<C-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-l>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-n>", ":noh<CR>", opts)
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
keymap("n", "vs", ":vs<CR>", opts)
keymap("n", "qv", ":q<CR>", opts)

-- Visual Mode mappings
keymap("v", "J",":m '>+1<CR>gv", opts)
keymap("v", "K",":m '<-2<CR>gv", opts)
keymap("v", "p", '"_dP', opts)
keymap("v", "//", "y/\\V<C-R>=escape(@\",'/\')<CR><CR>", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- Insert Mode mappings
-- Poor man's quote and bracket completion
keymap("i", "(", "()<Left>", opts)
keymap("i", "[", "[]<Left>", opts)
keymap("i", "{", "{}<Left>", opts)
keymap("i", "<", "<><Left>", opts)
keymap("i", "\'", "\'\'<Left>", opts)
keymap("i", "\"", "\"\"<Left>", opts)
