local lsp_conf = require "lspconfig"
local servers = { "clangd", "pyright", "lua_ls", "yamlls", "rust_analyzer"}
local server_opts = {
    lua_ls = {
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
                    checkThirdParty = false,
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
