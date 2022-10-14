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
map("v", "gy", "\"+y", opt)
map("n", "gp", "\"+p", opt)
map("v", "gp", "\"+p", opt)

-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 插件快捷键
local pluginKeys = {}

-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "mt", ":NvimTreeToggle<CR>", opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "s", action = "system_open" },
}
return pluginKeys
