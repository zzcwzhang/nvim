vim.g.mapleader = ","
vim.gmaplocalleader = ","

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- jk退出编辑模式
map("i", "jk", "<esc>", opt)

-- 快速行首行尾
map("i", "<C-a>", "<ESC>I", opt)
map("i", "<C-e>", "<ESC>A", opt)
map("n", "H", "^", opt)
map("n", "L", "$", opt)
map("v", "H", "^", opt)
map("v", "L", "$", opt)

-- 切换窗口
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-l>", "<C-w>l", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)

-- 切换tab
map("n", "<Left>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<Right>", ":BufferLineCycleNext<CR>", opt)

-- 关闭
map("n", "ZZ", ":bd<CR>", opt)

-- 系统粘贴板
map("n", "gy", '"+y', opt)
map("v", "gy", '"+y', opt)
map("n", "gp", '"+p', opt)
map("v", "gp", '"+p', opt)

-- git
map("n", "<leader>gd", ":Gdiffsplit<CR>", opt)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opt)
map("n", "<leader>fh", ":Telescope pickers<CR>", opt)
map("n", "<leader>fc", ":Telescope live_grep<CR>", opt)
map("n", "<leader>fg", ":Telescope git_status<CR>", opt)
map("n", "<leader>fm", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opt)

-- 查找当前关闭下的单词
map("n", "<leader>a", ":lua Search_word()<CR>", opt)
-- 书签
map("n", "<leader>p", ":lua require'telescope'.extensions.project.project{}<CR>", opt)

-- GPT
map("v", "T", ":<C-u>ChatGPTEditWithInstructions<CR>", opt)

-- trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opt)
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opt)
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opt)
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opt)
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opt)
map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opt)

-- 插件快捷键
local pluginKeys = {}

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
	return {
		-- 出现补全
		["<C-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		["<C-,>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- 上一个
		["<C-k>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- 确认
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- 如果窗口内容太多，可以滚动
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	}
end

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		-- 历史记录
		["<C-n>"] = "cycle_history_next",
		["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

-- bufferline
-- 左右Tab切换
--
-- 关闭
--"moll/vim-bbye"
-- map("n", "zz", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

-- nvim-tree
map("n", "<leader>m", ":NvimTreeFindFile<CR>", opt)
-- map("n", "mb", ':lua require"nvim-tree.api".marks.list()<CR>', opt)
-- map("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next, opt)
-- map("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev, opt)

map("n", "rc", ":lua Reload_config()<CR>", opt)
map("n", "rr", ":luafile %<CR>", opt)

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
	-- rename
	mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
	-- code action
	mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
	-- go xx
	mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
	mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
	mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
	mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
	mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
	-- diagnostic
	mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
	mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
	mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
	mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
	-- 没用到
	-- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
	-- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
	-- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
	-- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
	-- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
	-- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- 代码片段 snapshot
map("i", "<C-n>", "<Plug>luasnip-next-choice", {})
map("s", "<C-n>", "<Plug>luasnip-next-choice", {})
map("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
map("s", "<C-p>", "<Plug>luasnip-prev-choice", {})

return pluginKeys
