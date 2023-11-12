local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map("n", "rr", ":!rustc % && ./%:r<CR>", opt)
