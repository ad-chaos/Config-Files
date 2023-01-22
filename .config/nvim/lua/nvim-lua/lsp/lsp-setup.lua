local lsp_conf = require "lspconfig"
local servers = { "clangd", "pyright", "sumneko_lua", "yamlls", "rust_analyzer"}
local server_opts = {
    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.stdpath "config" .. "/lua"] = true,
                    },
                },
            },
        },
    },
}
for _, server in ipairs(servers) do
    local opts = {
        on_attach = require("nvim-lua.lsp.handlers").on_attach,
        capabilities = require("nvim-lua.lsp.handlers").capabilities,
    }

    if server_opts[server] then
        opts = vim.tbl_deep_extend("force", server_opts[server], opts)
    end

    lsp_conf[server].setup(opts)
end
