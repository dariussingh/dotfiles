return {
  -- Mason core plugin
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
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
}
