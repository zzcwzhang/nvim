local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 null-ls")
  return
end

local formatting = null_ls.builtins.formatting
null_ls.setup({
  debug = false,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.shellcheck,
    -- Formatting ---------------------
    --  brew install shfmt
    -- formatting.shfmt,
    -- -- StyLua
    -- formatting.stylua,
    -- -- frontend
    -- formatting.prettier.with({ -- 只比默认配置少了 markdown
    --   filetypes = {
    --     "javascript",
    --     "javascriptreact",
    --     "typescript",
    --     "typescriptreact",
    --     "vue",
    --     "css",
    --     "scss",
    --     "less",
    --     "html",
    --     "json",
    --     "yaml",
    --     "graphql",
    --   },
    --   prefer_local = "node_modules/.bin",
    -- }),
    -- formatting.fixjson,
    -- formatting.black.with({ extra_args = { "--fast" } }),
  },
  -- 保存自动格式化
  on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opt = {noremap = true, silent = true }

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end



