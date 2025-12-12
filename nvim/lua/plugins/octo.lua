return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  event = { { event = "BufReadCmd", pattern = "octo://*" } },
  opts = {
    use_local_fs = false,
    enable_builtin = false,
    default_remote = { "upstream", "origin" },
    default_merge_method = "commit",
    ssh_aliases = {},
    reaction_viewer_hint_icon = "",
    user_icon = " ",
    timeline_marker = "",
    timeline_indent = 2,
    right_bubble_delimiter = "",
    left_bubble_delimiter = "",
    github_hostname = "",
    snippet_context_lines = 4,
    gh_env = {},
    timeout = 5000,
    ui = {
      use_signcolumn = true,
    },
    issues = {
      order_by = {
        field = "CREATED_AT",
        direction = "DESC",
      },
    },
    pull_requests = {
      order_by = {
        field = "CREATED_AT",
        direction = "DESC",
      },
      always_select_remote_on_create = false,
    },
    file_panel = {
      size = 10,
      use_icons = true,
    },
    mappings = {
      issue = {
        close_issue = { lhs = "<leader>ghic", desc = "close issue" },
        reopen_issue = { lhs = "<leader>ghio", desc = "reopen issue" },
        list_issues = { lhs = "<leader>ghil", desc = "list open issues" },
        reload = { lhs = "<C-r>", desc = "reload issue" },
        open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        add_assignee = { lhs = "<leader>ghaa", desc = "add assignee" },
        remove_assignee = { lhs = "<leader>ghad", desc = "remove assignee" },
        create_label = { lhs = "<leader>ghlc", desc = "create label" },
        add_label = { lhs = "<leader>ghla", desc = "add label" },
        remove_label = { lhs = "<leader>ghld", desc = "remove label" },
        goto_issue = { lhs = "<leader>ghgi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<leader>ghca", desc = "add comment" },
        delete_comment = { lhs = "<leader>ghcd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        react_hooray = { lhs = "<leader>ghrp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<leader>ghrh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<leader>ghre", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<leader>ghr+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<leader>ghr-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<leader>ghrr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<leader>ghrl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<leader>ghrc", desc = "add/remove 😕 reaction" },
      },
      pull_request = {
        checkout_pr = { lhs = "<leader>ghpo", desc = "checkout PR" },
        merge_pr = { lhs = "<leader>ghpm", desc = "merge commit PR" },
        squash_and_merge_pr = { lhs = "<leader>ghpsm", desc = "squash and merge PR" },
        rebase_and_merge_pr = { lhs = "<leader>ghprm", desc = "rebase and merge PR" },
        list_commits = { lhs = "<leader>ghpc", desc = "list PR commits" },
        list_changed_files = { lhs = "<leader>ghpf", desc = "list PR changed files" },
        show_pr_diff = { lhs = "<leader>ghpd", desc = "show PR diff" },
        add_reviewer = { lhs = "<leader>ghva", desc = "add reviewer" },
        remove_reviewer = { lhs = "<leader>ghvd", desc = "remove reviewer" },
        close_issue = { lhs = "<leader>ghic", desc = "close PR" },
        reopen_issue = { lhs = "<leader>ghio", desc = "reopen PR" },
        list_issues = { lhs = "<leader>ghil", desc = "list open issues" },
        reload = { lhs = "<C-r>", desc = "reload PR" },
        open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        goto_file = { lhs = "gf", desc = "go to file" },
        add_assignee = { lhs = "<leader>ghaa", desc = "add assignee" },
        remove_assignee = { lhs = "<leader>ghad", desc = "remove assignee" },
        create_label = { lhs = "<leader>ghlc", desc = "create label" },
        add_label = { lhs = "<leader>ghla", desc = "add label" },
        remove_label = { lhs = "<leader>ghld", desc = "remove label" },
        goto_issue = { lhs = "<leader>ghgi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<leader>ghca", desc = "add comment" },
        delete_comment = { lhs = "<leader>ghcd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        react_hooray = { lhs = "<leader>ghrp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<leader>ghrh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<leader>ghre", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<leader>ghr+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<leader>ghr-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<leader>ghrr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<leader>ghrl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<leader>ghrc", desc = "add/remove 😕 reaction" },
        review_start = { lhs = "<leader>ghvs", desc = "start a review" },
        review_resume = { lhs = "<leader>ghvr", desc = "resume a review" },
      },
      review_thread = {
        goto_issue = { lhs = "<leader>ghgi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<leader>ghca", desc = "add comment" },
        add_suggestion = { lhs = "<leader>ghsa", desc = "add suggestion" },
        delete_comment = { lhs = "<leader>ghcd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
        select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
        select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        react_hooray = { lhs = "<leader>ghrp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<leader>ghrh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<leader>ghre", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<leader>ghr+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<leader>ghr-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<leader>ghrr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<leader>ghrl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<leader>ghrc", desc = "add/remove 😕 reaction" },
      },
      submit_win = {
        approve_review = { lhs = "<C-a>", desc = "approve review" },
        comment_review = { lhs = "<C-m>", desc = "comment review" },
        request_changes = { lhs = "<C-r>", desc = "request changes review" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      },
      review_diff = {
        submit_review = { lhs = "<leader>ghvs", desc = "submit review" },
        discard_review = { lhs = "<leader>ghvd", desc = "discard review" },
        add_review_comment = { lhs = "<leader>ghca", desc = "add a new review comment" },
        add_review_suggestion = { lhs = "<leader>ghsa", desc = "add a new review suggestion" },
        focus_files = { lhs = "<leader>ghe", desc = "move focus to changed file panel" },
        toggle_files = { lhs = "<leader>ghb", desc = "hide/show changed files panel" },
        next_thread = { lhs = "]t", desc = "move to next thread" },
        prev_thread = { lhs = "[t", desc = "move to previous thread" },
        select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
        select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
        select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
        goto_file = { lhs = "gf", desc = "go to file" },
      },
      file_panel = {
        submit_review = { lhs = "<leader>ghvs", desc = "submit review" },
        discard_review = { lhs = "<leader>ghvd", desc = "discard review" },
        next_entry = { lhs = "j", desc = "move to next changed file" },
        prev_entry = { lhs = "k", desc = "move to previous changed file" },
        select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
        refresh_files = { lhs = "R", desc = "refresh changed files panel" },
        focus_files = { lhs = "<leader>ghe", desc = "move focus to changed file panel" },
        toggle_files = { lhs = "<leader>ghb", desc = "hide/show changed files panel" },
        select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
        select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
        select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
      },
    },
  },
  keys = {
    -- GitHub namespace
    { "<leader>gh", "", desc = "+github" },
    { "<leader>ghc", "", desc = "+comment" },
    { "<leader>ghi", "", desc = "+issue" },
    { "<leader>ghl", "", desc = "+label" },
    { "<leader>gha", "", desc = "+assignee" },
    { "<leader>ghr", "", desc = "+reaction" },
    { "<leader>ghp", "", desc = "+pull request" },
    { "<leader>ghv", "", desc = "+review" },
    { "<leader>ghs", "", desc = "+suggestion" },

    -- Issues
    { "<leader>ghil", "<cmd>Octo issue list<cr>", desc = "List issues" },
    { "<leader>ghis", "<cmd>Octo issue search<cr>", desc = "Search issues" },
    { "<leader>ghin", "<cmd>Octo issue create<cr>", desc = "Create new issue" },
    { "<leader>ghie", "<cmd>Octo issue edit<cr>", desc = "Edit current issue" },
    { "<leader>ghib", "<cmd>Octo issue browser<cr>", desc = "Open issue in browser" },
    { "<leader>ghiu", "<cmd>Octo issue url<cr>", desc = "Copy issue URL" },

    -- Pull Requests
    { "<leader>ghpl", "<cmd>Octo pr list<cr>", desc = "List PRs" },
    { "<leader>ghps", "<cmd>Octo pr search<cr>", desc = "Search PRs" },
    { "<leader>ghpn", "<cmd>Octo pr create<cr>", desc = "Create new PR" },
    { "<leader>ghpe", "<cmd>Octo pr edit<cr>", desc = "Edit current PR" },
    { "<leader>ghpb", "<cmd>Octo pr browser<cr>", desc = "Open PR in browser" },
    { "<leader>ghpu", "<cmd>Octo pr url<cr>", desc = "Copy PR URL" },
    { "<leader>ghpr", "<cmd>Octo pr reload<cr>", desc = "Reload PR" },
    { "<leader>ghpk", "<cmd>Octo pr checks<cr>", desc = "Show PR checks" },

    -- Reviews
    { "<leader>ghvs", "<cmd>Octo review start<cr>", desc = "Start review" },
    { "<leader>ghvr", "<cmd>Octo review resume<cr>", desc = "Resume review" },
    { "<leader>ghvc", "<cmd>Octo review commit<cr>", desc = "Review commit" },
    { "<leader>ghvd", "<cmd>Octo review discard<cr>", desc = "Discard review" },
    { "<leader>ghvb", "<cmd>Octo review submit<cr>", desc = "Submit review" },
    { "<leader>ghvl", "<cmd>Octo review comments<cr>", desc = "List review comments" },

    -- Repo commands
    { "<leader>ghrl", "<cmd>Octo repo list<cr>", desc = "List user repos" },
    { "<leader>ghrv", "<cmd>Octo repo view<cr>", desc = "View repo" },
    { "<leader>ghrf", "<cmd>Octo repo fork<cr>", desc = "Fork repo" },
    { "<leader>ghrb", "<cmd>Octo repo browser<cr>", desc = "Open repo in browser" },
    { "<leader>ghru", "<cmd>Octo repo url<cr>", desc = "Copy repo URL" },

    -- Gists
    { "<leader>ghgl", "<cmd>Octo gist list<cr>", desc = "List gists" },

    -- Search
    { "<leader>ghss", "<cmd>Octo search<cr>", desc = "Search GitHub" },

    -- Actions
    { "<leader>ghat", "<cmd>Octo actions<cr>", desc = "Run GitHub action" },

    -- Thread/Comment navigation (these work in PR/Issue buffers)
    { "<leader>ghn", "]c", desc = "Next comment", remap = true },
    { "<leader>ghN", "[c", desc = "Previous comment", remap = true },
  },
  config = function(_, opts)
    require("octo").setup(opts)

    -- Set up autocommands for better UX
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "octo",
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 2
      end,
    })

    -- Add some useful highlights
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "OctoEditable", { bg = "#1e2030", fg = "#c8d3f5" })
        vim.api.nvim_set_hl(0, "OctoBubble", { bg = "#2d3f76" })
        vim.api.nvim_set_hl(0, "OctoUser", { fg = "#86e1fc", bold = true })
        vim.api.nvim_set_hl(0, "OctoUserViewer", { fg = "#c099ff", bold = true })
      end,
    })
  end,
}
