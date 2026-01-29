return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  dependencies = {
    "tpope/vim-rhubarb", -- GitHub integration for :GBrowse
  },
  cmd = {
    "Git",
    "G",
    "Gwrite",
    "Gread",
    "Gdiffsplit",
    "Gvdiffsplit",
    "Gedit",
    "Gsplit",
    "GMove",
    "GRename",
    "GDelete",
    "GRemove",
    "GBrowse",
  },
  keys = {
    -- Git status
    { "<leader>gg", "<cmd>Git<cr>", desc = "Git status" },
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },

    -- Git commit
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
    { "<leader>gC", "<cmd>Git commit --amend<cr>", desc = "Git commit (amend)" },

    -- Git push/pull
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
    { "<leader>gP", "<cmd>Git pull<cr>", desc = "Git pull" },
    { "<leader>gf", "<cmd>Git fetch<cr>", desc = "Git fetch" },

    -- Git branch
    { "<leader>gb", "<cmd>Git branch<cr>", desc = "Git branch" },
    { "<leader>gB", "<cmd>Git checkout -b ", desc = "Git new branch" },
    { "<leader>gco", "<cmd>Git checkout ", desc = "Git checkout" },

    -- Git diff
    { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff (vertical split)" },
    { "<leader>gD", "<cmd>Gdiffsplit<cr>", desc = "Git diff (horizontal split)" },

    -- Git blame
    { "<leader>gl", "<cmd>Git blame<cr>", desc = "Git blame" },

    -- Git log
    { "<leader>gL", "<cmd>Git log<cr>", desc = "Git log" },
    { "<leader>glo", "<cmd>Git log --oneline<cr>", desc = "Git log (oneline)" },

    -- Git stage/unstage
    { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git stage file" },
    { "<leader>gr", "<cmd>Gread<cr>", desc = "Git checkout file" },

    -- Git stash
    { "<leader>gS", "<cmd>Git stash<cr>", desc = "Git stash" },
    { "<leader>gsp", "<cmd>Git stash pop<cr>", desc = "Git stash pop" },

    -- Git merge/rebase
    { "<leader>gm", "<cmd>Git merge ", desc = "Git merge" },
    { "<leader>gR", "<cmd>Git rebase ", desc = "Git rebase" },

    -- Git remote
    { "<leader>grm", "<cmd>Git remote -v<cr>", desc = "Git remotes" },

    -- GitHub browse (requires vim-rhubarb)
    { "<leader>go", "<cmd>GBrowse<cr>", desc = "Open in GitHub", mode = { "n", "v" } },
    { "<leader>gO", "<cmd>GBrowse!<cr>", desc = "Copy GitHub URL", mode = { "n", "v" } },

    -- Git file history
    { "<leader>gF", "<cmd>Git log -- %<cr>", desc = "File history" },

    -- Git show
    { "<leader>gsh", "<cmd>Git show<cr>", desc = "Git show" },
  },
  config = function()
    -- Set up additional keymaps in Git status buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Refresh status
        vim.keymap.set("n", "r", "<cmd>e<cr>", { buffer = bufnr, desc = "Refresh" })

        -- Quick commit
        vim.keymap.set("n", "cc", "<cmd>Git commit<cr>", { buffer = bufnr, desc = "Commit" })
        vim.keymap.set("n", "ca", "<cmd>Git commit --amend<cr>", { buffer = bufnr, desc = "Amend commit" })

        -- Push/Pull
        vim.keymap.set("n", "gp", "<cmd>Git push<cr>", { buffer = bufnr, desc = "Push" })
        vim.keymap.set("n", "gP", "<cmd>Git pull<cr>", { buffer = bufnr, desc = "Pull" })
        vim.keymap.set("n", "gf", "<cmd>Git fetch<cr>", { buffer = bufnr, desc = "Fetch" })
      end,
    })

    -- Set up keymaps in Git commit buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "gitcommit",
      callback = function()
        -- Exit insert mode with jk or kj (consistent with global config)
        vim.keymap.set("i", "jk", "<Esc>", { buffer = true, silent = true })
        vim.keymap.set("i", "kj", "<Esc>", { buffer = true, silent = true })
      end,
    })
  end,
}
