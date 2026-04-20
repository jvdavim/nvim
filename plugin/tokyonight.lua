vim.pack.add({"https://github.com/folke/tokyonight.nvim.git"})
vim.cmd[[colorscheme tokyonight-night]]

-- Make vertical split separators lighter so they're easier to see.
-- Set both VertSplit (legacy) and WinSeparator (newer Neovim) highlight groups.
-- Adjust the hex color to taste; this is a neutral slate gray that works with
-- the tokyonight-night dark background.
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#4b5563", bg = "NONE" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#4b5563", bg = "NONE" })
