-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local opts = { silent = true }

local wt_cmd = ':lua save_cursor = vim.fn.getpos(".")  vim.cmd([[%s/\\s\\+$//e]]) vim.fn.setpos(".", save_cursor)<CR>'
map("n", "<Leader>wt", wt_cmd, { silent = true, desc = "remove whitespace" })
map("n", "<leader>r", "<cmd>Edit!<CR>")
if vim.g.vscode then
  map("n", "<c-/>", "<Nop>", opts)
  map("n", "<c-_>", "<Nop>", opts)
  -- map("n", "<c-/>", ":call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>", opts)
  map("n", "<leader>d", ":call VSCodeNotify('workbench.action.tasks.runTask', 'Flash')<CR>", opts)
  map("n", "<leader>b", ":call VSCodeNotify('workbench.action.tasks.build')<CR>", opts)
  -- map("n", "<leader>j", ":call VSCodeNotify('workbench.action.togglePanel')<CR>", opts)
  map("n", "<leader>z", ":call VSCodeNotify('workbench.action.toggleZenMode')<CR>", opts)
  map("n", "L", ":call VSCodeNotify('workbench.action.nextEditor')<CR>", opts)
  map("n", "H", ":call VSCodeNotify('workbench.action.previousEditor')<CR>", opts)
  -- map("n", "<leader><leader>", ":call VSCodeNotify('workbench.action.quickOpen')<CR>", opts)
  map("n", "<leader>ff", ":call VSCodeNotify('workbench.action.quickOpen')<CR>", opts)
end
