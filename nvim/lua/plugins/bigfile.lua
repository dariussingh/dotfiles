return {
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 10, -- threshold in MiB
      pattern = { "*" }, -- apply to all files
      features = {
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimopts",
        "filetype",
      },
    },
  },
}

