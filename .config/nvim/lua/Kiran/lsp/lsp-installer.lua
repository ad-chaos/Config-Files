local lsp_installer = require "nvim-lsp-installer"

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("Kiran.lsp.handlers").on_attach,
        capabilities = require("Kiran.lsp.handlers").capabilities,
    }

    if server.name == "pyright" then
        local pyright_opts = require "Kiran.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server.name == "sumneko_lua" then
        local sumneko_opts = require "Kiran.lsp.settings.sumneko"
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
