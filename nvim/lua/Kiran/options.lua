p = vim.opt

p.number = true
p.relativenumber = true

p.ignorecase = true
p.smartcase = true

-- Annoying things
vim.cmd [[set noerrorbells]]
vim.cmd [[set pumheight=10]]
p.visualbell = true
p.shortmess:append "I"

--Useful to use mouse sometimes
p.mouse:append "a"

-- 4 spaces are better than 1 tab
p.softtabstop = 4
p.shiftwidth = 4
p.expandtab = true

--Intuitive spliting behaviour
p.splitbelow = true
p.splitright = true

--Enable more colors!
p.termguicolors = true

-- cmp related shit
p.completeopt = { "menuone", "noselect"}
