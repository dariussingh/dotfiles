return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    { "<leader>gG", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit (current file)" },
    { "<leader>gl", "<cmd>LazyGitFilter<cr>", desc = "LazyGit (commits)" },
    { "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit (file history)" },
  },
  config = function()
    -- Make lazygit take up the full screen
    vim.g.lazygit_floating_window_scaling_factor = 1.0 -- Full screen (0.0 to 1.0)
    vim.g.lazygit_floating_window_winblend = 0 -- No transparency

    -- Add jk and kj as ESC alternatives in lazygit terminal
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*lazygit*",
      callback = function()
        vim.keymap.set("t", "jk", "<Esc>", { buffer = true, silent = true })
        vim.keymap.set("t", "kj", "<Esc>", { buffer = true, silent = true })
      end,
    })
  end,
}
