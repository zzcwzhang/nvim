local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end


local project_utils = require("telescope._extensions.project.utils")
local action_state = require "telescope.actions.state"

-- 添加书签
local add_bookmark = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local __path = current_picker.finder.path

  local projects = project_utils.get_project_objects()
  local path_not_in_projects = true

  -- 使用“w”模式打开文件时，表示覆盖写入模式
  -- 如果该文件不存在，则创建一个新文件并打开以进行写入操作。
  -- 如果文件已经存在，则该文件的内容将被覆盖掉。
  -- 如果要在现有文件中追加内容而不是覆盖现有内容，则应该使用“a”模式。
  local file = io.open(project_utils.telescope_projects_file, "w")

  for _, project in pairs(projects) do
    if project.path == __path then
      project.activated = 1
      path_not_in_projects = false
    end
    -- 将读取到的重新写入
    project_utils.store_project(file, project)
  end

  -- 如果不存在则加入到list
  if path_not_in_projects then
    local new_project = project_utils.get_project_from_path(__path)
    project_utils.store_project(file, new_project)
  end

  io.close(file)
  print('Project added: ' .. __path)
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- 窗口内快捷键
    mappings = require("keybindings").telescopeList,
  },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
      -- theme = "dropdown", 
    }
  },
  extensions = {
     -- 扩展插件配置
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- 增加到project
          ['<C-b>'] = add_bookmark
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- 增加到project
          ['<C-b>'] = add_bookmark
          -- your custom normal mode mappings
        },
      },
    },
  },
})

telescope.load_extension "file_browser"
telescope.load_extension('project')
