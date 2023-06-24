require("nvim-treesitter.configs").setup({
    sync_install = false,
    ensure_installed = { "lua", "python", "cpp", "c", "javascript", "toml", "markdown", "rust", "comment", "html", "css", "typescript"},
    highlight = {
        enable = true,
        disable = { "" },
    },
    -- TODO: Remove python once it is fixed upstream
    indent = { enable = true, disable = { "python" } },
    incremental_selection = { enable = false },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>l'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>h'] = '@parameter.inner',
      },
    },
  },
})
