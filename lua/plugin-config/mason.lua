local status, mason = pcall(require, "mason")
if not status then
	vim.notify("没有找到 mason")
	return
end

local lspconfig = require("lspconfig")

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

require("mason").setup({
	registries = {
		"lua:mason-registry.index", -- over time this registry will be depleted of packages and replaced with the one below
		-- Note that the mason-org/mason-registry very frequently releases new versions (usually many times a day).
		-- Pinning the version means that users wont receive new packages or version upgrades.
		"github:mason-org/mason-registry@2023-03-20-knotty-zipper", -- pinned version
	},
})
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	-- ["rust_analyzer"] = function()
	-- 	require("rust-tools").setup({})
	-- end,
})

require("lspconfig").tsserver.setup({
	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
})

-- require('mason-lspconfig').setup_handlers({
--   function(server)
--     lspconfig[server].setup({})
--   end,
--   ['tsserver'] = function()
--     lspconfig.tsserver.setup({
--       settings = {
--         completions = {
--           completeFunctionCalls = true
--         }
--       }
--     })
--   end
-- })
--
