return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim", -- optional, for template selection
  },
  opts = {
    workspaces = {
      {
        name = "obsidian_db",
        path = "~/Development/Obsidian/obsidian_db/",
      },
    },

    notes_subdir = "",

    daily_notes = {
      folder = "daily",
      date_format = "daily-dump-%Y-%m-%d",
      template = "daily-dump-template",
      default_tags = {},
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    completion = {
      nvim_cmp = false,
    },
  },

  config = function(_, opts)
    local obsidian = require("obsidian")
    local Path = require("plenary.path")
    local scan = require("plenary.scandir")

    local function expand_home(path)
      return path:gsub("^~", vim.fn.expand("$HOME"))
    end

    obsidian.setup(opts)

    -- Keymaps
    local map = vim.keymap.set
    map("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian app" })
    map("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New note" })
    map("n", "<leader>ot", "<cmd>ObsidianToday<cr>", { desc = "Open today's daily note" })
    map("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's daily note" })

    -- Custom: Create note from template
    local function create_note_from_template()
      local vault_path = expand_home(opts.workspaces[1].path)
      local templates_dir = Path:new(vault_path) / opts.templates.folder
      local templates = scan.scan_dir(tostring(templates_dir), {
        depth = 1,
        search_pattern = "%.md$",
      })

      if vim.tbl_isempty(templates) then
        vim.notify("No templates found in " .. tostring(templates_dir), vim.log.levels.WARN)
        return
      end

      local choices = {}
      for _, path in ipairs(templates) do
        table.insert(choices, Path:new(path):make_relative(tostring(templates_dir)))
      end

      vim.ui.select(choices, { prompt = "Select a template:" }, function(choice)
        if choice then
          vim.ui.input({ prompt = "New note name: " }, function(note_name)
            if note_name and #note_name > 0 then
              -- Define new note path
              local note_path = Path:new(vault_path) / (note_name .. ".md")

              -- Prevent overwriting an existing note
              if note_path:exists() then
                vim.notify("Note already exists: " .. tostring(note_path), vim.log.levels.ERROR)
                return
              end

              -- Read template content
              local template_path = tostring(templates_dir / choice)
              local template_content = Path:new(template_path):read()

              -- Write template into new note
              note_path:write(template_content, "w")

              -- Open the new note
              vim.cmd("edit " .. tostring(note_path))
            end
          end)
        end
      end)
    end

    map("n", "<leader>oc", create_note_from_template, { desc = "Create note from template" })
  end,
}

