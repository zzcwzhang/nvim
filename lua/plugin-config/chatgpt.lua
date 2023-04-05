local status, chatgpt = pcall(require, "chatgpt")
if not status then
    vim.notify("没有找到 chatgpt")
  return
end

-- chatgpt 配置
chatgpt.setup()

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