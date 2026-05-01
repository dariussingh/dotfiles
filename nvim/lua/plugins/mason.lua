return {
  -- Mason core plugin
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "clang-format",
        "clangd",
        "codelldb",
        "debugpy",
        "flake8",
        "isort",
        "js-debug-adapter",
        "lua-language-server", -- for mason: package name is 'lua-language-server'
        "pyright",
        "ruff",
        "shfmt",
        "stylua",
      },
    },
  },
  -- add clangd to lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- clangd will be automatically installed with mason and loaded with lspconfig
        clangd = {},
      },
    },
  },
  -- add c and cpp treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add c and cpp treesitter
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
      })
    end,
  },
}
