return {
  -- Mason core plugin
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "clang-format",
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
