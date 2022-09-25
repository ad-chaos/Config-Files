OPT = vim.opt

OPT.number = true
OPT.relativenumber = true
OPT.ignorecase = true
OPT.smartcase = true
OPT.visualbell = true
OPT.shortmess:append "I"
OPT.mouse:append "a"
OPT.softtabstop = 4
OPT.shiftwidth = 4
OPT.expandtab = true
OPT.splitbelow = true
OPT.splitright = true
OPT.termguicolors = true
OPT.completeopt = { "menuone", "noselect" }
OPT.diffopt:append { "algorithm:patience", "indent-heuristic" }
OPT.pumheight = 10
OPT.nrformats:append "alpha"
OPT.autochdir = true
OPT.foldmethod = "marker"
OPT.fo:append("/", "r", "o")
OPT.laststatus = 3
OPT.gdefault = true
OPT.list = true
OPT.listchars = { tab = ">> ", eol = "↲", nbsp = "␣", trail = "•" }
OPT.undofile = true
OPT.wrap = false
OPT.scrolloff = 5
OPT.showmode = false
OPT.showcmd = false
OPT.cpoptions:remove("_")
