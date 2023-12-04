if vim.g.nolsp then
    return
end
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local function on_attach(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
    vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", bufopts)
    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
    vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', bufopts)
    vim.keymap.set("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', bufopts)
    vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', bufopts)
    vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", bufopts)
end

local lsp_conf = require("lspconfig")
local servers = { "clangd", "pylsp", "lua_ls", "yamlls", "rust_analyzer", "tsserver", "gopls" }
local server_opts = vim.defaulttable()

local pylsp = server_opts.pylsp.settings
pylsp.plugins.pylsp_mypy.enabled = true
pylsp.plugins.pylsp_mypy.dmypy = true
pylsp.plugins.pylsp_mypy.overrides =
    { "--new-type-inference", "--enable-incomplete-feature=TypeVarTuple", "--enable-incomplete-feature=Unpack", true }
pylsp.plugins.ruff.enabled = true
pylsp.plugins.rope_autoimport.enabled = true
pylsp.plugins.rope_autoimport.memory = true
pylsp.plugins.rope_completion.enabled = true

local luals = server_opts.lua_ls.settings
luals.Lua.runtime.version = "LuaJIT"
luals.Lua.diagnostics.globals = { "vim" }
luals.Lua.workspace.library = {
    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    [vim.fn.stdpath("config") .. "/lua"] = true,
}
luals.workspace.library.checkThirdParty = false

local tsserver = server_opts.tsserver.settings
tsserver.javascript.suggestionActions.enabled = false

for _, server in ipairs(servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
    }

    if server_opts[server] then
        opts = vim.tbl_deep_extend("force", server_opts[server], opts)
    end

    lsp_conf[server].setup(opts)
end
