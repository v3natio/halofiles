local helpers = require('snippets-helper')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {
  -- print
  s(
    { trig = 'pp', snippetType = 'autosnippet' },
    fmta(
      [[
        print(<>)
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- do, return, end
  s(
    { trig = 'XX', snippetType = 'autosnippet' },
    fmta(
      [[
        do return end
        ]],
      {}
    ),
    { condition = line_begin }
  ),
}
