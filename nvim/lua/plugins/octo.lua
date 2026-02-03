return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    use_local_fs = false,
    enable_builtin = true,
    default_remote = { "upstream", "origin" },
    default_merge_method = "squash",
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
        close_issue = { lhs = "<leader>ic", desc = "close issue" },
        reopen_issue = { lhs = "<leader>io", desc = "reopen issue" },
        list_issues = { lhs = "<leader>il", desc = "list open issues" },
        reload = { lhs = "<C-r>", desc = "reload issue" },
        open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to clipboard" },
        add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
        remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
        create_label = { lhs = "<leader>lc", desc = "create label" },
        add_label = { lhs = "<leader>la", desc = "add label" },
        remove_label = { lhs = "<leader>ld", desc = "remove label" },
        goto_issue = { lhs = "<leader>gi", desc = "navigate to issue" },
        add_comment = { lhs = "<leader>ca", desc = "add comment" },
        delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "next comment" },
        prev_comment = { lhs = "[c", desc = "previous comment" },
        react_hooray = { lhs = "<leader>rp", desc = "react with party" },
        react_heart = { lhs = "<leader>rh", desc = "react with heart" },
        react_eyes = { lhs = "<leader>re", desc = "react with eyes" },
        react_thumbs_up = { lhs = "<leader>r+", desc = "react with thumbs up" },
        react_thumbs_down = { lhs = "<leader>r-", desc = "react with thumbs down" },
        react_rocket = { lhs = "<leader>rr", desc = "react with rocket" },
        react_laugh = { lhs = "<leader>rl", desc = "react with laugh" },
        react_confused = { lhs = "<leader>rc", desc = "react with confused" },
      },
      pull_request = {
        checkout_pr = { lhs = "<leader>po", desc = "checkout PR" },
        merge_pr = { lhs = "<leader>pm", desc = "merge commit PR" },
        squash_and_merge_pr = { lhs = "<leader>psm", desc = "squash and merge PR" },
        rebase_and_merge_pr = { lhs = "<leader>prm", desc = "rebase and merge PR" },
        list_commits = { lhs = "<leader>pc", desc = "list PR commits" },
        list_changed_files = { lhs = "<leader>pf", desc = "list PR changed files" },
        show_pr_diff = { lhs = "<leader>pd", desc = "show PR diff" },
        add_reviewer = { lhs = "<leader>va", desc = "add reviewer" },
        remove_reviewer = { lhs = "<leader>vd", desc = "remove reviewer" },
        close_issue = { lhs = "<leader>ic", desc = "close PR" },
        reopen_issue = { lhs = "<leader>io", desc = "reopen PR" },
        list_issues = { lhs = "<leader>il", desc = "list open issues" },
        reload = { lhs = "<C-r>", desc = "reload PR" },
        open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to clipboard" },
        goto_file = { lhs = "gf", desc = "go to file" },
        add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
        remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
        create_label = { lhs = "<leader>lc", desc = "create label" },
        add_label = { lhs = "<leader>la", desc = "add label" },
        remove_label = { lhs = "<leader>ld", desc = "remove label" },
        goto_issue = { lhs = "<leader>gi", desc = "navigate to issue" },
        add_comment = { lhs = "<leader>ca", desc = "add comment" },
        delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "next comment" },
        prev_comment = { lhs = "[c", desc = "previous comment" },
        react_hooray = { lhs = "<leader>rp", desc = "react with party" },
        react_heart = { lhs = "<leader>rh", desc = "react with heart" },
        react_eyes = { lhs = "<leader>re", desc = "react with eyes" },
        react_thumbs_up = { lhs = "<leader>r+", desc = "react with thumbs up" },
        react_thumbs_down = { lhs = "<leader>r-", desc = "react with thumbs down" },
        react_rocket = { lhs = "<leader>rr", desc = "react with rocket" },
        react_laugh = { lhs = "<leader>rl", desc = "react with laugh" },
        react_confused = { lhs = "<leader>rc", desc = "react with confused" },
        review_start = { lhs = "<leader>vs", desc = "start review" },
        review_resume = { lhs = "<leader>vr", desc = "resume review" },
      },
      review_thread = {
        goto_issue = { lhs = "<leader>gi", desc = "navigate to issue" },
        add_comment = { lhs = "<leader>ca", desc = "add comment" },
        add_suggestion = { lhs = "<leader>sa", desc = "add suggestion" },
        delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "next comment" },
        prev_comment = { lhs = "[c", desc = "previous comment" },
        select_next_entry = { lhs = "]q", desc = "move to next entry" },
        select_prev_entry = { lhs = "[q", desc = "move to previous entry" },
        select_first_entry = { lhs = "[Q", desc = "move to first entry" },
        select_last_entry = { lhs = "]Q", desc = "move to last entry" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        react_hooray = { lhs = "<leader>rp", desc = "react with party" },
        react_heart = { lhs = "<leader>rh", desc = "react with heart" },
        react_eyes = { lhs = "<leader>re", desc = "react with eyes" },
        react_thumbs_up = { lhs = "<leader>r+", desc = "react with thumbs up" },
        react_thumbs_down = { lhs = "<leader>r-", desc = "react with thumbs down" },
        react_rocket = { lhs = "<leader>rr", desc = "react with rocket" },
        react_laugh = { lhs = "<leader>rl", desc = "react with laugh" },
        react_confused = { lhs = "<leader>rc", desc = "react with confused" },
      },
      submit_win = {
        approve_review = { lhs = "<C-a>", desc = "approve review" },
        comment_review = { lhs = "<C-m>", desc = "comment review" },
        request_changes = { lhs = "<C-r>", desc = "request changes" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      },
      review_diff = {
        submit_review = { lhs = "<leader>vs", desc = "submit review" },
        discard_review = { lhs = "<leader>vd", desc = "discard review" },
        add_review_comment = { lhs = "<leader>ca", desc = "add comment" },
        add_review_suggestion = { lhs = "<leader>sa", desc = "add suggestion" },
        focus_files = { lhs = "<leader>e", desc = "focus files panel" },
        toggle_files = { lhs = "<leader>b", desc = "toggle files panel" },
        next_thread = { lhs = "]t", desc = "next thread" },
        prev_thread = { lhs = "[t", desc = "previous thread" },
        select_next_entry = { lhs = "]q", desc = "move to next entry" },
        select_prev_entry = { lhs = "[q", desc = "move to previous entry" },
        select_first_entry = { lhs = "[Q", desc = "move to first entry" },
        select_last_entry = { lhs = "]Q", desc = "move to last entry" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        toggle_viewed = { lhs = "<leader><space>", desc = "toggle file viewed" },
        goto_file = { lhs = "gf", desc = "go to file" },
      },
      file_panel = {
        submit_review = { lhs = "<leader>vs", desc = "submit review" },
        discard_review = { lhs = "<leader>vd", desc = "discard review" },
        next_entry = { lhs = "j", desc = "next entry" },
        prev_entry = { lhs = "k", desc = "previous entry" },
        select_entry = { lhs = "<cr>", desc = "select entry" },
        refresh_files = { lhs = "R", desc = "refresh files" },
        focus_files = { lhs = "<leader>e", desc = "focus files panel" },
        toggle_files = { lhs = "<leader>b", desc = "toggle files panel" },
        select_next_entry = { lhs = "]q", desc = "move to next entry" },
        select_prev_entry = { lhs = "[q", desc = "move to previous entry" },
        select_first_entry = { lhs = "[Q", desc = "move to first entry" },
        select_last_entry = { lhs = "]Q", desc = "move to last entry" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        toggle_viewed = { lhs = "<leader><space>", desc = "toggle file viewed" },
      },
    },
  },
  keys = {
    -- Main GitHub interface commands
    { "<leader>gho", "<cmd>Octo<cr>", desc = "Octo menu" },
    { "<leader>ghh", "<cmd>Octo actions<cr>", desc = "Octo actions" },

    -- Issues
    { "<leader>ghil", "<cmd>Octo issue list<cr>", desc = "List issues" },
    { "<leader>ghis", "<cmd>Octo issue search<cr>", desc = "Search issues" },
    { "<leader>ghic", "<cmd>Octo issue create<cr>", desc = "Create issue" },
    { "<leader>ghio", "<cmd>Octo issue browser<cr>", desc = "Open issue in browser" },
    { "<leader>ghie", "<cmd>Octo issue edit<cr>", desc = "Edit issue" },
    { "<leader>ghiC", "<cmd>Octo issue close<cr>", desc = "Close issue" },
    { "<leader>ghir", "<cmd>Octo issue reopen<cr>", desc = "Reopen issue" },
    { "<leader>ghiu", "<cmd>Octo issue url<cr>", desc = "Copy issue URL" },

    -- Pull Requests
    { "<leader>ghpl", "<cmd>Octo pr list<cr>", desc = "List PRs" },
    { "<leader>ghps", "<cmd>Octo pr search<cr>", desc = "Search PRs" },
    { "<leader>ghpc", "<cmd>Octo pr create<cr>", desc = "Create PR" },
    { "<leader>ghpo", "<cmd>Octo pr browser<cr>", desc = "Open PR in browser" },
    { "<leader>ghpe", "<cmd>Octo pr edit<cr>", desc = "Edit PR" },
    { "<leader>ghpC", "<cmd>Octo pr close<cr>", desc = "Close PR" },
    { "<leader>ghpr", "<cmd>Octo pr reopen<cr>", desc = "Reopen PR" },
    { "<leader>ghpk", "<cmd>Octo pr checkout<cr>", desc = "Checkout PR" },
    { "<leader>ghpd", "<cmd>Octo pr diff<cr>", desc = "Show PR diff" },
    { "<leader>ghpm", "<cmd>Octo pr merge squash<cr>", desc = "Merge PR (squash)" },
    { "<leader>ghpM", "<cmd>Octo pr merge commit<cr>", desc = "Merge PR (commit)" },
    { "<leader>ghpR", "<cmd>Octo pr merge rebase<cr>", desc = "Merge PR (rebase)" },
    { "<leader>ghpf", "<cmd>Octo pr changes<cr>", desc = "List PR changed files" },
    { "<leader>ghpD", "<cmd>Octo pr commits<cr>", desc = "List PR commits" },
    { "<leader>ghpu", "<cmd>Octo pr url<cr>", desc = "Copy PR URL" },
    { "<leader>ghpy", "<cmd>Octo pr ready<cr>", desc = "Mark PR ready" },
    { "<leader>ghpP", "<cmd>Octo pr checks<cr>", desc = "Show PR checks" },

    -- Reviews
    { "<leader>ghrs", "<cmd>Octo review start<cr>", desc = "Start review" },
    { "<leader>ghrr", "<cmd>Octo review resume<cr>", desc = "Resume review" },
    { "<leader>ghrS", "<cmd>Octo review submit<cr>", desc = "Submit review" },
    { "<leader>ghrd", "<cmd>Octo review discard<cr>", desc = "Discard review" },
    { "<leader>ghrc", "<cmd>Octo review comments<cr>", desc = "View review comments" },
    { "<leader>ghrC", "<cmd>Octo review commit<cr>", desc = "Review commit" },

    -- Comments
    { "<leader>ghca", "<cmd>Octo comment add<cr>", desc = "Add comment" },
    { "<leader>ghcd", "<cmd>Octo comment delete<cr>", desc = "Delete comment" },

    -- Threads
    { "<leader>ghtr", "<cmd>Octo thread resolve<cr>", desc = "Resolve thread" },
    { "<leader>ghtu", "<cmd>Octo thread unresolve<cr>", desc = "Unresolve thread" },

    -- Labels
    { "<leader>ghla", "<cmd>Octo label add<cr>", desc = "Add label" },
    { "<leader>ghld", "<cmd>Octo label remove<cr>", desc = "Remove label" },
    { "<leader>ghlc", "<cmd>Octo label create<cr>", desc = "Create label" },

    -- Assignees
    { "<leader>ghaa", "<cmd>Octo assignee add<cr>", desc = "Add assignee" },
    { "<leader>ghad", "<cmd>Octo assignee remove<cr>", desc = "Remove assignee" },

    -- Reviewers
    { "<leader>ghva", "<cmd>Octo reviewer add<cr>", desc = "Add reviewer" },
    { "<leader>ghvd", "<cmd>Octo reviewer remove<cr>", desc = "Remove reviewer" },

    -- Reactions
    { "<leader>ghe+", "<cmd>Octo reaction thumbs_up<cr>", desc = "React 👍" },
    { "<leader>ghe-", "<cmd>Octo reaction thumbs_down<cr>", desc = "React 👎" },
    { "<leader>gheh", "<cmd>Octo reaction heart<cr>", desc = "React ❤️" },
    { "<leader>ghep", "<cmd>Octo reaction hooray<cr>", desc = "React 🎉" },
    { "<leader>gher", "<cmd>Octo reaction rocket<cr>", desc = "React 🚀" },
    { "<leader>ghel", "<cmd>Octo reaction laugh<cr>", desc = "React 😄" },
    { "<leader>ghec", "<cmd>Octo reaction confused<cr>", desc = "React 😕" },
    { "<leader>ghee", "<cmd>Octo reaction eyes<cr>", desc = "React 👀" },

    -- Gist
    { "<leader>ghgl", "<cmd>Octo gist list<cr>", desc = "List gists" },

    -- Repo
    { "<leader>ghRl", "<cmd>Octo repo list<cr>", desc = "List user repos" },
    { "<leader>ghRf", "<cmd>Octo repo fork<cr>", desc = "Fork repo" },
    { "<leader>ghRb", "<cmd>Octo repo browser<cr>", desc = "Open repo in browser" },
    { "<leader>ghRu", "<cmd>Octo repo url<cr>", desc = "Copy repo URL" },

    -- Card
    { "<leader>ghkm", "<cmd>Octo card move<cr>", desc = "Move card" },
    { "<leader>ghkd", "<cmd>Octo card remove<cr>", desc = "Remove card" },
    { "<leader>ghka", "<cmd>Octo card add<cr>", desc = "Add card" },
  },
  config = function(_, opts)
    require("octo").setup(opts)

    -- Set up custom highlights to match your colorscheme
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "OctoEditable", { link = "NormalFloat" })
        vim.api.nvim_set_hl(0, "OctoBubble", { link = "NormalFloat" })
        vim.api.nvim_set_hl(0, "OctoDirty", { link = "ErrorMsg" })
      end,
    })

    -- Add jk and kj as ESC alternatives in Octo buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "octo",
      callback = function()
        vim.keymap.set("i", "jk", "<Esc>", { buffer = true, silent = true })
        vim.keymap.set("i", "kj", "<Esc>", { buffer = true, silent = true })
      end,
    })
  end,
}
