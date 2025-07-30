return {
  "epwalsh/obsidian.nvim",
  version = "*", -- latest stable
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "obsidian_db",
        path = "~/Development/Obsidian/obsidian_db/", -- vault path
      },
    },

    -- Store all new notes in vault root
    notes_subdir = "",

    -- Daily notes configuration
    daily_notes = {
      folder = "daily",
      date_format = "daily-dump-%Y-%m-%d", -- custom file name
      template = "daily-dump-template", -- just the template filename (no .md needed)
      default_tags = {},
    },

    -- Templates folder configuration
    templates = {
      folder = "templates", -- relative to vault root
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    completion = {
      nvim_cmp = false,
    },
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Keymaps
    local map = vim.keymap.set
    map("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian app" })
    map("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New note" })
    map("n", "<leader>ot", "<cmd>ObsidianToday<cr>", { desc = "Open today's daily note" })
    map("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's daily note" })
  end,
}

