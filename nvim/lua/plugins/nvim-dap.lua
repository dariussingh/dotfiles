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
      local dap = require("dap")

      local function mason_package_path(package)
        local ok, registry = pcall(require, "mason-registry")
        if not ok then
          return nil
        end

        local ok_pkg, pkg = pcall(registry.get_package, package)
        if not ok_pkg then
          return nil
        end

        if not pkg:is_installed() then
          return nil
        end

        return pkg:get_install_path()
      end

      local function get_codelldb_adapter()
        local codelldb_path = mason_package_path("codelldb")
        if not codelldb_path then
          return nil
        end

        local adapter = codelldb_path .. "/extension/adapter/codelldb"
        if vim.fn.has("win32") == 1 then
          adapter = adapter .. ".exe"
        end

        return adapter
      end

      -- Call the original config if you want to preserve everything (as loaded by lazy extras)
      local loaded, dap_extra = pcall(require, "lazyvim.plugins.extras.dap.core")
      if loaded and dap_extra and dap_extra.config then
        dap_extra.config()
      end

      local codelldb_adapter = get_codelldb_adapter()
      if codelldb_adapter then
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = codelldb_adapter,
            args = { "--port", "${port}" },
          },
        }

        local cpp_configurations = {
          {
            name = "Launch executable",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
        }

        for _, lang in ipairs({ "c", "cpp" }) do
          dap.configurations[lang] = cpp_configurations
        end
      end

      -- Add your additional config here (for example: load_launchjs for python/cpp adapters)
      -- Wrap in pcall to avoid errors when launch.json is empty or invalid
      pcall(function()
        require("dap.ext.vscode").load_launchjs(nil, {
          codelldb = { "c", "cpp" },
          debugpy = { "python" },
          lldb = { "c", "cpp" },
          python = { "python" },
        })
      end)
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
