local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason")
  return
end


local lspconfig = require('lspconfig')

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- ensure_installed = {
  --   'tsserver',
  --   'lua',
  --   'eslint',
  --   'html',
  --   'cssls'
  -- }
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
