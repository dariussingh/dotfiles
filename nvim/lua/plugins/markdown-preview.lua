-- lua/plugins/markdown-preview.lua
return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_theme = "dark" -- change to "light" if you prefer
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },
    },
  },
}

