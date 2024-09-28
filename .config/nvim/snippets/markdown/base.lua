local helpers = require('snippets-helper')
local ts_helpers = require('snippets-treesitter')
local get_visual = helpers.get_visual
local clipboard_content = helpers.clipboard_content
local line_begin = require('luasnip.extras.expand_conditions').line_begin
local in_text = ts_helpers.in_text
local in_mathzone = ts_helpers.in_mathzone

-- function to dynamically generate markdown table content
local generate_markdown_table = function(args, snip)
  local rows = tonumber(snip.captures[1])
  local cols = tonumber(snip.captures[2])
  local nodes = {}
  -- header
  table.insert(nodes, t('| '))
  for k = 1, cols do
    table.insert(nodes, i(k, ' '))
    table.insert(nodes, t(' | '))
  end
  table.insert(nodes, t({ '', '' }))
  -- separator
  table.insert(nodes, t('|'))
  for k = 1, cols do
    table.insert(nodes, t(':---:'))
    table.insert(nodes, t('|'))
  end
  table.insert(nodes, t({ '', '' }))
  -- content
  local ins_indx = cols + 1
  for j = 1, rows - 1 do
    table.insert(nodes, t('| '))
    for k = 1, cols do
      table.insert(nodes, i(ins_indx, ' '))
      table.insert(nodes, t(' | '))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ '', '' }))
  end
  return sn(nil, nodes)
end

return {
  -- new title
  s(
    { trig = 'h1', snippetType = 'autosnippet' },
    fmta('# <>', {
      d(1, get_visual),
    })
  ),
  -- new subtitle
  s(
    { trig = 'h2', snippetType = 'autosnippet' },
    fmta('## <>', {
      d(1, get_visual),
    })
  ),
  -- new section
  s(
    { trig = 'h3', snippetType = 'autosnippet' },
    fmta('### <>', {
      d(1, get_visual),
    })
  ),
  -- new subsection
  s(
    { trig = 'h4', snippetType = 'autosnippet' },
    fmta('#### <>', {
      d(1, get_visual),
    })
  ),
  -- new math item
  s({ trig = 'ii', snippetType = 'autosnippet' }, { t('&') }, { condition = in_mathzone }),
  -- new item
  s({ trig = 'ii', snippetType = 'autosnippet' }, { t('- ') }, { condition = line_begin }),
  -- math line end
  s({ trig = 'br', snippetType = 'autosnippet' }, { t('&&\\\\') }, { condition = in_mathzone }),
  -- TODO
  s({ trig = 'TODOO', snippetType = 'autosnippet' }, {
    t('**TODO:** '),
  }),
  -- URL
  s(
    { trig = 'LL', snippetType = 'autosnippet' },
    fmta([[[<>](<>)]], {
      f(clipboard_content, {}),
      d(1, get_visual),
    })
  ),
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
  -- table
  s(
    { trig = 'tbl(%d+)x(%d+)', regTrig = true, snippetType = 'autosnippet' },
    d(1, generate_markdown_table),
    { condition = line_begin }
  ),
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
          &<>
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
          <>
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
        <>
      \end{cases}
      ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = in_mathzone }
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
