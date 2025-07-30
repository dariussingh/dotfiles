return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-neotest/nvim-nio" },
  keys = {
    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },

    -- Enhanced Eval + Add to Watch
    {
      "<leader>de",
      function()
        local dapui = require("dapui")
        local mode = vim.fn.mode()
        local expr = nil

        if mode == "v" or mode == "V" or mode == "\22" then
          -- Get visual selection
          local start_pos = vim.fn.getpos("'<")
          local end_pos = vim.fn.getpos("'>")
          local lines = vim.fn.getline(start_pos[2], end_pos[2])
          -- Trim to selection columns
          if #lines > 0 then
            lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
            lines[1] = string.sub(lines[1], start_pos[3])
          end
          expr = table.concat(lines, " ")
        else
          -- Normal mode: word under cursor
          expr = vim.fn.expand("<cword>")
        end

        -- Clean up expression
        expr = vim.trim(expr or "")
        expr = expr:gsub("\n", " "):gsub("%s+", " ")  -- collapse whitespace

        if expr ~= "" then
          dapui.eval(expr) -- evaluate
          pcall(function()
            dapui.elements.watches.add(expr) -- add to watch
          end)
        else
          vim.notify("No expression selected", vim.log.levels.WARN)
        end
      end,
      desc = "Eval + Watch",
      mode = { "n", "v" },
    },
  },
  opts = {},
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup(opts)
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
  end,
}

