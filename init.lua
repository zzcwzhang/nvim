-- 基础配置
require("basic")
-- Packer插件管理
require("plugins")
-- 快捷键映射
require("keybindings")
-- 主题设置 （新增）
require("colorscheme")
-- 插件配置 plugin-config为文件夹.后面为文件名
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.nvim-comment")
require("plugin-config.lualine")
require("plugin-config.telescope")
-- require("plugin-config.project")
require("plugin-config.nvim-treesitter")
require("plugin-config.chatgpt")
require("plugin-config.dashboard")
require("plugin-config.snippets")
require("plugin-config.mason")
-- require("lsp.setup")
require("lsp.cmp")
require("lsp.null-ls")
require("lsp.ui")
require("function")
