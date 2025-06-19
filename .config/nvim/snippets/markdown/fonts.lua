local helpers = require('snippets-helper')
local ts_helpers = require('snippets-treesitter')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin
local in_text = ts_helpers.in_text
local in_mathzone = ts_helpers.in_mathzone

return {
  -- bold
  s(
    { trig = 'tbb', snippetType = 'autosnippet' },
    fmta('**<>**', {
      d(1, get_visual),
    })
  ),
  -- italics
  s(
    { trig = 'tii', snippetType = 'autosnippet' },
    fmta('*<>*', {
      d(1, get_visual),
    })
  ),
  -- underline
  s(
    { trig = 'tuu', snippetType = 'autosnippet' },
    fmt([[<u>{}</u>]], {
      d(1, get_visual),
    })
  ),
  -- highlight
  s(
    { trig = 'thh', snippetType = 'autosnippet' },
    fmta('==<>==', {
      d(1, get_visual),
    })
  ),
}
