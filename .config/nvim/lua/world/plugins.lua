vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

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
        config = true,
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

    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

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
            current_line_blame = true,
            on_attach = function()
                local gs = require("gitsigns")
                vim.keymap.set("n", "<leader>gb", gs.blame_line)
                vim.keymap.set("n", "<leader>rh", gs.reset_hunk)
                vim.keymap.set("n", "<leader>rb", gs.reset_buffer)
                vim.keymap.set("n", "]g", gs.next_hunk)
                vim.keymap.set("n", "[g", gs.prev_hunk)
            end,
        },
        config = true,
    },

    {
        "sindrets/diffview.nvim",
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
        config = true,
    },

    -- LSP
    "neovim/nvim-lspconfig",

    --Tree Sitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            sync_install = false,
            ensure_installed = {
                "c",
                "comment",
                "cpp",
                "css",
                "html",
                "javascript",
                "lua",
                "rust",
                "toml",
                "typescript",
                "vim",
            },
            highlight = {
                enable = true,
            },
            -- TODO: Remove python once it is fixed upstream
            indent = { enable = true, disable = { "python" } },
            incremental_selection = { enable = false },
        },
        main = "nvim-treesitter.configs",
        config = true,
    },

    "nvim-treesitter/nvim-treesitter-context",

    -- Misc
    "nvim-tree/nvim-web-devicons",
    "chrisbra/Colorizer",
    "chaoren/vim-wordmotion",
    {
        "sbdchd/neoformat",
        config = function()
            vim.keymap.set("n", "<leader>fm", "<cmd>Neoformat<cr>")
        end,
    },

    {
        "kylechui/nvim-surround",
        config = true,
    },

    -- some fun
    "mbbill/undotree",
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {
            text = {
                spinner = "dots",
            },
        },
        config = true,
    },
}, {
    lockfile = vim.fn.stdpath("state") .. "lazy/lazy-lock.json",
})
