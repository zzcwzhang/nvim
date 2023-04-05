local cmp = require("cmp")
local luasnip = require("luasnip")

local defaultMapping = require("keybindings").cmp(cmp)
defaultMapping["<Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
    -- they way you will only jump inside the snippet region
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end, { "i", "s" })

defaultMapping["<S-Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end, { "i", "s" })

cmp.setup({
  -- 指定 snippet 引擎
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },

  -- 补全源
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = 'luasnip' },
  }, { { name = "buffer" }, { name = "path" } }),

  -- 快捷键设置
  -- mapping = require("keybindings").cmp(cmp),
  mapping = defaultMapping,
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
      { name = "cmdline" },
    }),
})
