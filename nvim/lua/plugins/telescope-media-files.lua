return {
  {
    "nvim-telescope/telescope-media-files.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          media_files = {
            -- filetypes to preview
            filetypes = { "png", "jpg", "jpeg", "gif", "webp", "pdf", "svg", "mp4", "mkv", "ttf", "otf", "epub" },
            find_cmd = "fd", -- or "rg"
          },
        },
      })
      -- load the extension
      require("telescope").load_extension("media_files")
    end,
    keys = {
      { "<leader>fm", "<cmd>Telescope media_files<cr>", desc = "Browse Media Files" },
    },
  },
}

