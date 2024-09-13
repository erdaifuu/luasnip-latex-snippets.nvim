local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node

local M = {}

function M.retrieve(not_math)
  local utils = require("luasnip-latex-snippets.util.utils")
  local pipe = utils.pipe

  local conds = require("luasnip.extras.expand_conditions")
  local condition = pipe({ conds.line_begin, not_math })

  local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
    condition = condition,
  }) --[[@as function]]

  local s = ls.extend_decorator.apply(ls.snippet, {
    condition = condition,
  }) --[[@as function]]

  return {
    s(
      { trig = "ali", name = "Align" },
      { t({ "\\begin{align*}", "\t" }), i(1), t({ "", ".\\end{align*}" }) }
    ),

    parse_snippet({ trig = "env", name = "begin{} / end{}" }, "\\begin{$1}\n\t$0\n\\end{$1}"),
    parse_snippet({ trig = "def", name = "begin{definition} / end{definition}" }, "\\begin{$1}\n\t$0\n\\end{$1}"),
    parse_snippet({ trig = "fig", name = "Insert Graphic" }, "\\includegraphics[scale=$1]{$2.png}$0"),
    
    parse_snippet({ trig = "case", name = "cases" }, "\\begin{cases}\n\t$1\n\\end{cases}"),
    parse_snippet({ trig = "fitch", name = "fitch proof" }, "$\\begin{nd}\n\t$1\n\\end{nd}$"),
    parse_snippet({ trig = "enum", name = "enumerate" }, "\\begin{enumerate}[$1]\n\t$2\n\\end{enumerate}"),

    parse_snippet({ trig = "h1", name = "section" }, "\\section{$1}$0"),
    parse_snippet({ trig = "h2", name = "subsection" }, "\\subsection{$1}$0"),
    
    s({ trig = "bigfun", name = "Big function" }, {
      t({ "\\begin{align*}", "\t" }),
      i(1),
      t(":"),
      t(" "),
      i(2),
      t("&\\longrightarrow "),
      i(3),
      t({ " \\", "\t" }),
      i(4),
      t("&\\longmapsto "),
      i(1),
      t("("),
      i(4),
      t(")"),
      t(" = "),
      i(0),
      t({ "", ".\\end{align*}" }),
    }),
  }
end

return M
