return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Run/Continue",
      },
      {
        "<leader>da",
        function()
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with Args",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dP",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
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
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
      -- Setup dap config from VSCode launch.json if available
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
      -- Loads .vscode/launch.json from the project root by default
      require("dap.ext.vscode").load_launchjs(nil, { debugpy = { "python" }, python = { "python" } })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Use active venv as the Python interpreter for debugging
      local function get_python_path()
        local venv_path = os.getenv("VIRTUAL_ENV")
        if venv_path ~= nil and venv_path ~= "" then
          return venv_path .. "/bin/python"
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
