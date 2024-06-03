if vim.g.nolsp then
    return
end

vim.diagnostic.config({
    underline = true,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignHint",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignInfo",
        },
    },
    float = {
        border = "rounded",
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local function on_attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, bufopts)
    vim.keymap.set("n", "<leader>rn", ":IncRename ", bufopts)
    vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)

    if client.name == "clangd" then
        local function switch()
            vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', {
                uri = vim.uri_from_bufnr(bufnr)
            }, function(err, uri, _, _)
                if err then
                    vim.cmd.echoe("Server Errored:")
                    print(vim.inspect(err))
                end
                if uri then
                    vim.cmd.edit(vim.uri_to_fname(uri))
                else
                    vim.notify("No corresponding implementation file!", vim.log.levels.ERROR)
                end
            end)
        end
        vim.keymap.set("n", "<leader>-", switch, bufopts)
    end
end

local lspconfig = require("lspconfig")
local servers = { "clangd", "pylsp", "lua_ls", "yamlls", "rust_analyzer", "tsserver", "gopls", "cmake" }
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local server_opts = vim.defaulttable()

local pylsp = server_opts.pylsp.settings
pylsp.plugins.pylsp_mypy.enabled = true
pylsp.plugins.pylsp_mypy.dmypy = true
pylsp.plugins.pylsp_mypy.overrides = { "--new-type-inference", "--enable-incomplete-feature=TypeVarTuple",
    "--enable-incomplete-feature=Unpack", "--check-untyped-defs" }
pylsp.plugins.ruff.enabled = true
pylsp.plugins.rope_autoimport.enabled = true
pylsp.plugins.rope_autoimport.memory = true
pylsp.plugins.rope_completion.enabled = true
pylsp.plugins.black.enabled = true

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

local rust_analyzer = server_opts.rust_analyzer.settings['rust-analyzer']
rust_analyzer.check.command = "clippy"

for _, server in ipairs(servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    if server_opts[server] then
        opts = vim.tbl_deep_extend("force", server_opts[server], opts)
    end

    lspconfig[server].setup(opts)
end
