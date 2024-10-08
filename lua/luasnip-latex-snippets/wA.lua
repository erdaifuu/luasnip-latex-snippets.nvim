local ls = require("luasnip")
local utils = require("luasnip-latex-snippets.util.utils")
local pipe = utils.pipe

local M = {}

function M.retrieve(not_math)
  local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
    condition = pipe({ not_math }),
  }) --[[@as function]]

  return {
    parse_snippet({ trig = "mk", name = "Math" }, "\\( ${1:${TM_SELECTED_TEXT}} \\)$0"),
    parse_snippet({ trig = "dm", name = "Block Math" }, "\\[\n\t${1:${TM_SELECTED_TEXT}}\n.\\] $0"),
    parse_snippet({ trig = "mm", name = "Tex Math" }, "$${1:${TM_SELECTED_TEXT}}$$0"),


    parse_snippet({ trig = "ttt", name = "Typewriter" }, "\\texttt{$1}$0"),
    parse_snippet({ trig = "tii", name = "Italics" }, "\\textit{$1}$0"),
    parse_snippet({ trig = "tbt", name = "Bold" }, "\\textbf{$1}$0"),
    parse_snippet({ trig = "tun", name = "Bold" }, "\\underline{$1}$0"),
  }
end

return M
