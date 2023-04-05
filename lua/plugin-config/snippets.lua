local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local postfix = require "luasnip.extras.postfix".postfix

-- ls.add_snippets("all", {
--   s("ternary", {
--     -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
--     i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
--   })
-- }, {
--     key = "all",
-- })


function capitalizeFirstWord(str)
  local firstChar = string.sub(str, 1, 1)
  local rest = string.sub(str, 2)
  return string.upper(firstChar) .. rest
end

ls.add_snippets("javascript", {
  s("tri", { t("Wow! Text!") }),

  s("uM", { t("const ["), i(1), t("] = useMemo()") }),

  -- useState
  postfix("?uS", {
    f(function(_, parent)
      local str = parent.snippet.env.POSTFIX_MATCH
      return "const [" .. str ..", " .. "set" .. capitalizeFirstWord(str) .. "] = useState(" .. str .. ");"
    end, {}),
  }),

  -- useRecoilState
  postfix("?uRS", {
    f(function(_, parent)
      local str = parent.snippet.env.POSTFIX_MATCH
      return "const [" .. str ..", " .. "set" .. capitalizeFirstWord(str) .. "] = useRecoilState(" .. str .. "$);"
    end, {}),
  }),

}, {
    key = "javascript",
  })

require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "javascript" } })
