vim.g.netrw_banner = 0
vim.g.mapleader = " "
vim.g.loaded_python3_provider = 0

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

require("lazy").setup({
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            on_colors = function(colors)
                colors.bg = "#0d0e12"
                colors.bg_dark = "#0d0e12"
                colors.bg_highlight = "#0d0e12"
            end,
        },
        lazy = false,
        priority = 1000,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
        },
    },

    -- Fuzzy File Finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local telescope = require("telescope")
            local telescope_builtin = require("telescope.builtin")
            local action_layout = require("telescope.actions.layout")

            telescope.setup({
                defaults = {
                    prompt_prefix = "  ",
                    selection_caret = "  ",
                    mappings = {
                        i = {
                            ["?"] = action_layout.toggle_preview,
                        },
                    },
                },
            })

            telescope.load_extension("fzf")
            vim.keymap.set("n", "<leader>fl", telescope_builtin.find_files)
            vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep)
            vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files)
            vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers)
            vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags)
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
            },
            on_attach = function()
                local gs = require("gitsigns")
                vim.keymap.set("n", "<leader>gb", gs.blame_line)
                vim.keymap.set("n", "<leader>rh", gs.reset_hunk)
                vim.keymap.set("n", "<leader>rb", gs.reset_buffer)
                vim.keymap.set("n", "]g", gs.next_hunk)
                vim.keymap.set("n", "[g", gs.prev_hunk)
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
        cmd = "DiffviewOpen",
        opts = {
            merge_tool = {
                layout = "diff4_mixed",
            },
            file_panel = {
                win_config = { -- See |diffview-config-win_config|
                    position = "left",
                    width = 25,
                    win_opts = {},
                },
            },
        },
    },

    -- LSP
    "neovim/nvim-lspconfig",

    --Tree Sitter
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",

    -- Misc
    "nvim-tree/nvim-web-devicons",
    { "chrisbra/Colorizer", lazy = true },
    {
        "echasnovski/mini.ai",
        opts = {
            search_method = 'cover_or_nearest'
        },
    },
    {
        "kylechui/nvim-surround",
        config = true,
    },

    -- some fun
    "mbbill/undotree",
    {
        "j-hui/fidget.nvim",
        config = true,
        lazy = true,
    },

    {
        "iamcco/markdown-preview.nvim",
        lazy = true,
    },

    {
        "3rd/image.nvim",
        opts = {
            max_height_window_percentage = 100,
        },
        lazy = true,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    {
        "smjonas/inc-rename.nvim",
        event = "LspAttach",
        config = true,
    }
}, {
    lockfile = vim.fn.stdpath("state") .. "lazy/lazy-lock.json",
    ui = {
        border = "rounded"
    },
})

vim.cmd.colorscheme("tokyonight-night")
vim.o.statusline = "%!v:lua.require'statusline'.statusline()"
