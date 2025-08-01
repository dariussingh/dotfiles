-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Exit insert mode with jk or kj
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape insert mode", noremap = true, silent = true })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Escape insert mode", noremap = true, silent = true })
-- Got to definition vscode style
vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to Definition (VSCode style)" })
-- Obsidian
vim.keymap.set("n", "<leader>o", "", { desc = "Obsidian" })
-- Markdown-preview
vim.keymap.set("n", "<leader>m", "", { desc = "Markdown" })
