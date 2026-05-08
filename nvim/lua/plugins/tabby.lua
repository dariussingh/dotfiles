return {
  {
    "TabbyML/vim-tabby",
    lazy = false,

    dependencies = {
      "neovim/nvim-lspconfig",
    },

    init = function()
      vim.g.tabby_agent_start_command = {
        "tabby-agent",
        "--stdio",
      }

      vim.g.tabby_inline_completion_trigger = "auto"

      -- accept completion
      vim.g.tabby_inline_completion_keybinding_accept = "<C-g>"
      vim.g.tabby_inline_completion_keybinding_accept = "<C-g>"


      -- trigger/dismiss
      vim.g.tabby_inline_completion_keybinding_trigger_or_dismiss =
        "<C-e>"
    end,
  },
}
