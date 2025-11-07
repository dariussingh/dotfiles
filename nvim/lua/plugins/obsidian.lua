return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim", -- for pickers
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

    local map = vim.keymap.set

    ---------------------------------------------------------------------------
    -- 🗂️  Obsidian Command Keymaps (flat, unique, all under <leader>o)
    ---------------------------------------------------------------------------
    map("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian app" })
    map("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New note" })
    map("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch note" })
    map("n", "<leader>of", "<cmd>ObsidianFollowLink<cr>", { desc = "Follow link under cursor" })
    map("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Show backlinks" })
    map("n", "<leader>og", "<cmd>ObsidianTags<cr>", { desc = "Search by tags" })
    map("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Open today's note" })
    map("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's note" })
    map("n", "<leader>om", "<cmd>ObsidianTomorrow<cr>", { desc = "Open tomorrow's note" })
    map("n", "<leader>oa", "<cmd>ObsidianDailies<cr>", { desc = "List daily notes" })
    map("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Insert template" })
    map("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Search notes" })
    map("v", "<leader>ol", "<cmd>ObsidianLink<cr>", { desc = "Link selection to existing note" })
    map("v", "<leader>ok", "<cmd>ObsidianLinkNew<cr>", { desc = "Create & link new note" })
    map("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "List all links in buffer" })
    map("n", "<leader>ox", "<cmd>ObsidianExtractNote<cr>", { desc = "Extract selection to note" })
    map("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>", { desc = "Switch workspace" })
    map("n", "<leader>oi", "<cmd>ObsidianPasteImg<cr>", { desc = "Paste image from clipboard" })
    map("n", "<leader>or", "<cmd>ObsidianRename<cr>", { desc = "Rename note" })
    map("n", "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", { desc = "Toggle checkbox" })
    map("n", "<leader>oe", "<cmd>ObsidianNewFromTemplate<cr>", { desc = "New note from template" })
    map("n", "<leader>oT", "<cmd>ObsidianTOC<cr>", { desc = "Table of contents" })

    ---------------------------------------------------------------------------
    -- 🧩 Custom: Manual create note from template
    ---------------------------------------------------------------------------
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
              local note_path = Path:new(vault_path) / (note_name .. ".md")
              if note_path:exists() then
                vim.notify("Note already exists: " .. tostring(note_path), vim.log.levels.ERROR)
                return
              end

              local template_path = tostring(templates_dir / choice)
              local template_content = Path:new(template_path):read()

              note_path:write(template_content, "w")
              vim.cmd("edit " .. tostring(note_path))
            end
          end)
        end
      end)
    end

    -- Custom function mapped separately to avoid overlap
    map("n", "<leader>oC", create_note_from_template, { desc = "Create note from template (custom)" })
  end,
}

