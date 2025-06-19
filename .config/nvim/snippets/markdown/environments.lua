local helpers = require('snippets-helper')
local ts_helpers = require('snippets-treesitter')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin
local in_mathzone = ts_helpers.in_mathzone

-- get_visual implementation for callouts
local function format_as_callout(_, parent)
  local selected_text = parent.snippet.env.SELECT_RAW or {}
  -- add '> ' to each line of the selected text
  local formatted_text = {}
  for _, line in ipairs(selected_text) do
    table.insert(formatted_text, '> ' .. line)
  end
  return sn(nil, t(formatted_text))
end

return {
  -- inline math
  s(
    { trig = 'mm', snippetType = 'autosnippet' },
    fmta('$<>$', {
      i(1),
    })
  ),
  -- equation
  s(
    { trig = 'nn', snippetType = 'autosnippet' },
    fmta(
      [[
        $$
        \begin{flalign*}
          &<> &&\\
        \end{flalign*}
        $$
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- split equation
  s(
    { trig = 'sss', snippetType = 'autosnippet' },
    fmta(
      [[
        $$
        \begin{split}
          <> \\
        \end{split}
        $$
      ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- equation with cases
  s(
    { trig = 'ssc', snippetType = 'autosnippet' },
    fmta(
      [[
      \begin{cases}
        <> \\
      \end{cases}
      ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = in_mathzone }
  ),
  -- generic callout
  s(
    { trig = 'ngen', snippetType = 'autosnippet' },
    fmta(
      [[
        >> [!ad-<>] <>
        <>
      ]],
      {
        i(1, 'Type'),
        i(2, 'Title'),
        d(3, format_as_callout),
      }
    ),
    { condition = line_begin }
  ),
  -- proposition
  s(
    { trig = 'npro', snippetType = 'autosnippet' },
    fmta(
      [[
        >> [!ad-prop] Proposition
        <>
      ]],
      {
        d(1, format_as_callout),
      }
    ),
    { condition = line_begin }
  ),
  -- definition
  s(
    { trig = 'ndef', snippetType = 'autosnippet' },
    fmta(
      [[
        >> [!ad-def] Definition
        <>
      ]],
      {
        d(1, format_as_callout),
      }
    ),
    { condition = line_begin }
  ),
  -- remark
  s(
    { trig = 'nrem', snippetType = 'autosnippet' },
    fmta(
      [[
        >> [!ad-rem] Remark
        <>
      ]],
      {
        d(1, format_as_callout),
      }
    ),
    { condition = line_begin }
  ),
  -- code block
  s(
    { trig = 'cc', snippetType = 'autosnippet' },
    fmta(
      [[
        ```<>
        <>
        ```
      ]],
      {
        i(1),
        d(2, get_visual),
      }
    ),
    { condition = line_begin }
  ),
}
