vim.g.mapleader=" "
vim.gmaplocalleader=" "

local map = vim.api.nvim_set_keymap

local opt = {noremap = true, silent = true }

-- jk退出编辑模式
map("i", "jk", "<esc>", opt)

-- 快速行首行尾
map("i", "<C-a>", "<ESC>I", opt)
map("i", "<C-e>", "<ESC>A", opt)
map("n", "<C-a>", "^", opt)
map("n", "<C-e>", "$", opt)

-- 窗口移动
map("n", "<C-J>", "<C-W><C-J>", opt)
map("n", "<C-K>", "<C-W><C-K>", opt)
map("n", "<C-L>", "<C-W><C-L>", opt)
map("n", "<C-H>", "<C-W><C-H>", opt)

-- 系统粘贴板
map("n", "gy", "\"+y", opt)
map("n", "gp", "\"+p", opt)

-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)
