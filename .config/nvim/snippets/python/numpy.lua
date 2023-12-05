local helpers = require('snippets-helper')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {
  -- NP.LOADTXT
  s(
    { trig = 'nlt', snippetType = 'autosnippet' },
    fmta(
      [[
          np.loadtxt(<>)
        ]],
      {
        d(1, get_visual),
      }
    )
  ),
}
