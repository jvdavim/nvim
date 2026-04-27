-- Leader key and options must load first (before plugin/ files run).
require('options')
require('keymaps')
require('autocmds')

-- vim.pack.add() wrapper (must load before plugin/ files call it).
require('pack')

-- LSP servers, diagnostics, and custom commands.
require('lsp')
