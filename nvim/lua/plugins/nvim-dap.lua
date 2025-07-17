return {
  -- Extend nvim-dap with extra keymaps or config
  {
    "mfussenegger/nvim-dap",
    -- Add additional keymaps to the default ones
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Run/Continue (VSCode)",
      },
      {
        "<F6>",
        function()
          require("dap").pause()
        end,
        desc = "Pause (VSCode)",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint (VSCode)",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over (VSCode)",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into (VSCode)",
      },
      {
        "<S-F11>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out (VSCode)",
      },
      {
        "<S-F5>",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate (VSCode)",
      },
      {
        "<C-S-F5>",
        function()
          require("dap").run_last()
        end,
        desc = "Restart/Run Last (VSCode)",
      },
    },
    config = function()
      -- Call the original config if you want to preserve everything (as loaded by lazy extras)
      local loaded, dap_extra = pcall(require, "lazyvim.plugins.extras.dap.core")
      if loaded and dap_extra and dap_extra.config then
        dap_extra.config()
      end
      -- Add your additional config here (for example: load_launchjs for python adapters)
      require("dap.ext.vscode").load_launchjs(nil, { debugpy = { "python" }, python = { "python" } })
    end,
  },
  -- Add dap-python for python debugging
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local function get_python_path()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv and venv ~= "" then
          return venv .. "/bin/python"
        else
          return "python"
        end
      end
      require("dap-python").setup(get_python_path())
      require("dap-python").test_runner = "pytest"
    end,
    keys = {
      {
        "<leader>dPt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Method",
        ft = "python",
      },
      {
        "<leader>dPc",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Class",
        ft = "python",
      },
    },
    ft = "python",
  },
}
