P = vim.opt

P.number = true
P.relativenumber = true

P.ignorecase = true
P.smartcase = true

-- Annoying things
vim.cmd([[set noerrorbells]])
vim.cmd([[set pumheight=10]])
P.visualbell = true
P.shortmess:append("I")

--Useful to use mouse sometimes
P.mouse:append("a")

-- 4 spaces are better than 1 tab
P.softtabstop = 4
P.shiftwidth = 4
P.expandtab = true

--Intuitive spliting behaviour
P.splitbelow = true
P.splitright = true

--Enable more colors!
P.termguicolors = true

-- cmp related shit
P.completeopt = { "menuone", "noselect" }
