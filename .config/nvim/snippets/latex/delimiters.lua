local helpers = require('snippets-helper')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {
  -- left/right parentheses
  s(
    { trig = '([^%a])l%(', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\left( <> \\right)', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- left/right brackets
  s(
    { trig = '([^%a])l%[', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\left[ <> \\right]', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- left/right curly braces
  s(
    { trig = '([^%a])l%{', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\left\\{ <> \\right\\}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
}
