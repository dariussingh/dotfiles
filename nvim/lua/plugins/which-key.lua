return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    if opts.spec then
      vim.list_extend(opts.spec, {
        { "<leader>gh", group = "GitHub" },
        { "<leader>ghi", group = "Issues" },
        { "<leader>ghp", group = "Pull Requests" },
        { "<leader>ghr", group = "Reviews" },
        { "<leader>ghv", group = "Reviewers" },
        { "<leader>ghc", group = "Comments" },
        { "<leader>ght", group = "Threads" },
        { "<leader>ghl", group = "Labels" },
        { "<leader>gha", group = "Assignees" },
        { "<leader>ghe", group = "Reactions" },
        { "<leader>ghg", group = "Gists" },
        { "<leader>ghR", group = "Repo" },
        { "<leader>ghk", group = "Cards" },
      })
    end
    return opts
  end,
}
