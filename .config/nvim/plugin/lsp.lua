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

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            diagnostics = {
                globals = { "vim" }
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    checkThirdParty = false,
                }
            }
        }
    }
})

lspconfig.rust_analyzer.setup({
    settings = { ['rust-analyzer'] = { check = { command = 'clippy' } } },
})

lspconfig.clangd.setup({
    on_attach = function(_, bufnr)
    local function switch()
        vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', {
            uri = vim.uri_from_bufnr(bufnr)
        }, function(err, uri, _, _)
            if err then
                vim.cmd.echoe("Couldn't Switch:")
                print(vim.inspect(err))
            end
            if uri then
                vim.cmd.edit(vim.uri_to_fname(uri))
            else
                vim.notify("No corresponding implementation file:", vim.log.levels.ERROR)
            end
        end)
    end
    vim.keymap.set("n", "<leader>-", switch, {noremap = true, silent = true})
end
})

lspconfig.ts_ls.setup({
    settings = { javascript = { suggestionActions = { enabled = false } } }
})

lspconfig.yamlls.setup({})
lspconfig.gopls.setup({})
lspconfig.pyright.setup({})
lspconfig.cmake.setup({})

vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, bufopts)
        vim.keymap.set("n", "<leader>rn", ":IncRename ", bufopts)
        vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", bufopts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)
    end
})
