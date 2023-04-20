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
local postfix = require("luasnip.extras.postfix").postfix

ls.add_snippets("all", {
	s(
		"pwd",
		f(function()
			return vim.fn.getreg("%")
		end)
	),
}, {
	key = "all",
})

local function capitalizeFirstWord(str)
	local firstChar = string.sub(str, 1, 1)
	local rest = string.sub(str, 2)
	return string.upper(firstChar) .. rest
end

local function getFilename(path)
	local name = string.match(path, ".*/([^/]+)")
	if name == nil then
		return ""
	else
		name = string.match(name, "^(.+)%..+$") or name
		return name
	end
end

ls.add_snippets("javascript", {
	s("llg", fmt([[.tap((_v) => console.log("{}", _v))]], { i(1) })),

	-- recoil: selector
	s(
		"selector>",
		c(1, {
			fmta(
				[[
  export const [] = selector({
    key: `${BASE_FIX}[]`,
    get: ({ get }) => {
      []
      return null;
    }
  });
  ]],
				{ i(1), rep(1), i(2) },
				{ delimiters = "[]" }
			),
			fmt(
				[[
  export const [] = selectorFamily({
    key: `${BASE_FIX}[]`,
    get: ([]) => ({ get }) => {
      []
      return null;
    }
  });
  ]],
				{ i(1), rep(1), i(2, "value"), i(3, "") },
				{ delimiters = "[]" }
			),
		})
	),

	-- recoil: atom
	s(
		"atom>",
		c(1, {
			fmta(
				[[
  export const <> = atom({
    key: `${BASE_FIX}<>`,
    default: <>
  });
  ]],
				{ i(1), rep(1), i(2, "null") }
			),
			fmt(
				[[
  export const [] = atomFamily({
    key: `${BASE_FIX}[]`,
    default: []
  ]],
				{ i(1), rep(1), i(2, "null") },
				{ delimiters = "[]" }
			),
		})
	),

	-- styled-components
	s(
		"coms",
		fmt(
			[[
  const {} = styled.div`
    {}
  `;
  ]],
			{ i(1), i(2) }
		)
	),

	-- display: grid
	s(
		"dg",
		fmt(
			[[
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 1fr;
  grid-gap: 20px;
  grid-auto-flow: column;
  justify-content: stretch;
  justify-items: stretch;
  align-content: stretch;
  align-items: center;
  {}
  ]],
			{ i(1) }
		)
	),

	-- import
	-- s(
	-- 	"imp",
	-- 	fmt([[import {2} from '{1}';]], {
	-- 		i(1),
	-- 		f(function(args)
	-- 			return getFilename(args[1][1] or "")
	-- 		end, { 1 }),
	-- 	})
	-- ),
	s(
		"imp",
		fmt([[import {2} from '{1}';]], {
			i(1),
			i(2),
		})
	),
	s("im_", t({ "import _ from 'lodash';" })),
	-- useMemo
	s(
		"uM",
		fmt(
			[[
  const !@ = useMemo(() => {
    !@
  }, []);
  ]],
			{
				i(1),
				i(2),
			},
			{
				delimiters = "!@",
			}
		)
	),
	-- useCallback
	s(
		"uC",
		fmt(
			[[
  const !@ = useCallback(() => {
    !@
  }, []);
  ]],
			{
				i(1),
				i(2),
			},
			{
				delimiters = "!@",
			}
		)
	),
	-- fast create page
	s(
		"shook",
		fmt(
			[[
import React, { useState } from 'react';
import styled from 'styled-components';

export default function []() {
  return (
    <Wrapper>
      []
    </Wrapper>
  )
}

const Wrapper = styled.div`
  font-size: 20px;
`;
  ]],
			{
				i(1),
				rep(1),
			},
			{
				delimiters = "[]",
			}
		)
	),
	postfix(
		"$snapshot",
		c(1, {
			f(function(_, parent)
				local str = parent.snippet.env.POSTFIX_MATCH
				return "const " .. str .. " = snapshot.getLoadable(" .. str .. "$).contents;"
			end, {}),
			f(function(_, parent)
				local str = parent.snippet.env.POSTFIX_MATCH
				return "const " .. str .. " = await snapshot.getPromise(" .. str .. "$);"
			end, {}),
		})
	),
	-- selector get
	postfix("$get", {
		f(function(_, parent)
			local str = parent.snippet.env.POSTFIX_MATCH
			return "const " .. str .. " = get(" .. str .. "$);"
		end, {}),
	}),
	-- useState
	postfix("?US", {
		f(function(_, parent)
			local str = parent.snippet.env.POSTFIX_MATCH
			return "const [" .. str .. ", " .. "set" .. capitalizeFirstWord(str) .. "] = useState(" .. str .. ");"
		end, {}),
	}),
	-- useRecoilState
	postfix("$URS", {
		f(function(_, parent)
			local str = parent.snippet.env.POSTFIX_MATCH
			return "const ["
				.. str
				.. ", "
				.. "set"
				.. capitalizeFirstWord(str)
				.. "] = useRecoilState("
				.. str
				.. "$);"
		end, {}),
	}),
	-- useRecoilValue
	postfix("$URV", {
		f(function(_, parent)
			local str = parent.snippet.env.POSTFIX_MATCH
			return "const " .. str .. " = useRecoilValue(" .. str .. "$);"
		end, {}),
	}),
	-- console.log
	postfix("?L", {
		f(function(_, parent)
			local str = parent.snippet.env.POSTFIX_MATCH
			return "console.log('" .. str .. ":', " .. str .. ");"
		end, {}),
	}),
}, {
	key = "javascript",
})

require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "javascript" } })
