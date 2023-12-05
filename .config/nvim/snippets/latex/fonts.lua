local helpers = require('snippets-helper')
local ts_helpers = require('snippets-treesitter')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin
local in_text = ts_helpers.in_text
local in_mathzone = ts_helpers.in_mathzone

return {
  -- italics
  s(
    { trig = 'tii', snippetType = 'autosnippet' },
    fmta('\\textit{<>}', {
      d(1, get_visual),
    })
  ),
  -- bold
  s(
    { trig = 'tbb', snippetType = 'autosnippet' },
    fmta('\\textbf{<>}', {
      d(1, get_visual),
    })
  ),
  -- underline
  s(
    { trig = 'tuu', snippetType = 'autosnippet' },
    fmta('\\ul{<>}', {
      d(1, get_visual),
    })
  ),
  -- regular text (in mathmode)
  s(
    { trig = '([^%a])tee', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\text{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
}
