local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	vim.notify("没有找到nvim-tree")
	return
end

local api = require("nvim-tree.api")

local function opts(desc)
	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

local project_utils = require("telescope._extensions.project.utils")
local action_state = require("telescope.actions.state")
-- 添加书签
local add_bookmark = function(node)
	local __path = node["absolute_path"]

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
	print("Project added: " .. __path)
end

-- CD
local function change_root_to_file(node)
	local uv = require("luv")
	local file_path = node["absolute_path"]
	uv.chdir(file_path)
	api.tree.change_root(file_path)
end

-- 列表操作快捷键
-- local list_keys = require('keybindings').nvimTreeList
nvim_tree.setup({
	-- 过滤文件夹
	live_filter = {
		prefix = "[FILTER]: ",
		always_show_folders = false, -- Turn into false from true by default
	},
	open_on_tab = true,
	-- 不显示 git 状态图标
	git = {
		enable = true,
	},
	-- project plugin 需要这样设置
	-- sync_root_with_cwd = true,
	-- respect_buf_cwd = true,
	-- update_focused_file = {
	-- 	enable = true,
	-- 	update_root = false,
	-- },
	-- 隐藏 .文件 和 node_modules 文件夹
	filters = {
		dotfiles = true,
		custom = { "node_modules" },
	},
	view = {
		-- 宽度
		width = 34,
		-- 也可以 'right'
		side = "left",
		-- 隐藏根目录
		hide_root_folder = false,

		-- 原则
		-- 无改动的，则可以直接单键
		-- 会影响文件修改，则需要使用组合键
		mappings = {
			custom_only = true,
			list = {
				-- 有风险操作
				{ key = "<C-b>", action_cb = add_bookmark, desc = "添加到书签(只能目录)" },
				{ key = "<C-d>", action_cb = api.fs.remove, desc = "删除" },
				{ key = "<C-a>", action_cb = api.fs.create, desc = "创建" },
				{ key = "<C-o>", action_cb = api.node.run.system, desc = "系统打开" },
				{ key = "<C-r>", action_cb = api.fs.rename, desc = "重命名" },
				{ key = "<C-x>", action_cb = api.fs.cut, desc = "剪切" },
				{ key = "<C-c>", action_cb = api.fs.copy.node, desc = "复制" },
				{ key = "<C-p>", action_cb = api.fs.paste, desc = "粘贴" },
				{ key = "<C-r>", action_cb = api.fs.reload, desc = "刷新目录" },

				-- 设置根目录
				{ key = "cd", action_cb = change_root_to_file, desc = "cwd" },
				-- 打开方式
				{ key = "t", action_cb = api.node.open.ta, desc = "新标签页" },
				{ key = "v", action_cb = api.node.open.vertical, desc = "垂直打开" },
				{ key = "s", action_cb = api.node.open.horizontal, desc = "水平代开" },
				{ key = "o", action_cb = api.node.open.edit, desc = "进入或编辑" },

				-- 目录操作
				{ key = "u", action_cb = api.tree.change_root_to_parent, desc = "回到上级" },
				{ key = "E", action_cb = api.node.open.expand_all, desc = "全部展开" },
				{ key = "J", action_cb = api.node.navigate.sibling.last, desc = "移动到最后" },
				{ key = "K", action_cb = api.node.navigate.sibling.first, desc = "移动到最后" },

				-- 帮助
				{ key = "?", action_cb = api.tree.toggle_help, desc = "帮助" },
			},
		},
		-- 不显示行数
		number = false,
		relativenumber = false,
		-- 显示图标
		signcolumn = "yes",
	},
	actions = {
		open_file = {
			-- 首次打开大小适配
			resize_window = true,
			-- 打开文件时关闭
			quit_on_open = false,
		},
	},
	-- wsl install -g wsl-open
	-- https://github.com/4U6U57/wsl-open/
	system_open = {
		cmd = "open", -- mac 直接设置为 open
	},
})

-- 自动关闭
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
