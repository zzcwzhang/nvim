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
require("plugin-config.dashboard")
require("plugin-config.project")
require("plugin-config.nvim-treesitter")
require("lsp.setup")
require("lsp.cmp")
require("lsp.null-ls")
require("lsp.ui")


require("function")

require('chatgpt').setup()

vim.api.nvim_create_user_command("ChatGPT", function()
  require("chatgpt").openChat()
end, {})

vim.api.nvim_create_user_command("ChatGPTActAs", function()
  require("chatgpt").selectAwesomePrompt()
end, {})

vim.api.nvim_create_user_command("ChatGPTEditWithInstructions", function()
  require("chatgpt").edit_with_instructions()
end, {})

vim.api.nvim_create_user_command("ChatGPTRun", function(opts)
  require("chatgpt").run_action(opts)
end, {
  nargs = "*",
  range = true,
  complete = function()
    local ActionFlow = require("chatgpt.flows.actions")
    local action_definitions = ActionFlow.read_actions()

    local actions = {}
    for key, _ in pairs(action_definitions) do
      table.insert(actions, key)
    end
    table.sort(actions)

    return actions
  end,
})

vim.api.nvim_create_user_command("ChatGPTRunCustomCodeAction", function(opts)
  require("chatgpt").run_custom_code_action(opts)
end, {
  nargs = "*",
  range = true,
})

vim.api.nvim_create_user_command("ChatGPTCompleteCode", function(opts)
  require("chatgpt").complete_code(opts)
end, {})
