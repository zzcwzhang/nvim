function Reload_config()
	vim.cmd("source ~/.config/nvim/init.lua")
	print("Reloaded config!")
end

function Search_word()
	local text = vim.fn.expand("<cword>")
	require("telescope.builtin").live_grep({
		default_text = text,
	})
	print("ook")
end
