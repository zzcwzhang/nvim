local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map("n", "rc", ":lua Reload_config()<CR>", opt)
map("n", "rr", ":luafile %<CR>", opt)
