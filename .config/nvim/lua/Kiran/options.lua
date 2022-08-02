OPT = vim.opt

OPT.number = true
OPT.relativenumber = true

OPT.ignorecase = true
OPT.smartcase = true

-- Annoying things
OPT.visualbell = true
OPT.shortmess:append("I")

--Useful to use mouse sometimes
OPT.mouse:append("a")

-- 4 spaces are better than 1 tab
OPT.softtabstop = 4
OPT.shiftwidth = 4
OPT.expandtab = true

--Intuitive spliting behaviour
OPT.splitbelow = true
OPT.splitright = true

--Enable more colors!
OPT.termguicolors = true

-- cmp related shit
OPT.completeopt = { "menuone", "noselect" }

-- Extra opts, just look at :h
OPT.diffopt:append({ "algorithm:patience", "indent-heuristic" })
OPT.pumheight = 10
OPT.nrformats:append("alpha")
OPT.autochdir = true
OPT.foldmethod = "marker"
OPT.fo:append("/")
OPT.laststatus = 3
OPT.iskeyword:remove("_")
vim.cmd([[ let g:copilot_no_tab_map = v:true ]])
