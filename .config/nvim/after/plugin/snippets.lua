local ls = require("luasnip")

local snipper = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.snippets = {
    lua = {
        snipper("req", fmt("local {} = require('{}')", {i(1, "default"), rep(1)}))
    }
}
