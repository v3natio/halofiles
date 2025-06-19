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
  local i_counter = 0

  -- header
  table.insert(nodes, t('| '))
  for k = 1, cols do
    i_counter = i_counter + 1
    table.insert(nodes, i(i_counter, 'Column' .. i_counter))
    if k < cols then
      table.insert(nodes, t(' | '))
    else
      table.insert(nodes, t(' |'))
    end
  end
  table.insert(nodes, t({ '', '' }))

  -- separator
  local hlines = string.rep('|:---:', cols):sub(1, -2) .. '|'
  table.insert(nodes, t(hlines))
  table.insert(nodes, t({ '', '' }))

  -- content
  for _ = 1, rows - 1 do
    table.insert(nodes, t('| '))
    for k = 1, cols do
      i_counter = i_counter + 1
      table.insert(nodes, i(i_counter))
      if k < cols then
        table.insert(nodes, t(' | '))
      else
        table.insert(nodes, t(' |'))
      end
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
  -- new subsubsection
  s(
    { trig = 'h5', snippetType = 'autosnippet' },
    fmta('##### <>', {
      d(1, get_visual),
    })
  ),
  -- new math item
  s({ trig = 'ii', snippetType = 'autosnippet' }, { t('&') }, { condition = in_mathzone }),
  -- new item
  s({ trig = 'ii', snippetType = 'autosnippet' }, { t('- ') }, { condition = line_begin }),
  -- URL
  s(
    { trig = 'LL', snippetType = 'autosnippet' },
    fmta([[[<>](<>)]], {
      f(clipboard_content, {}),
      d(1, get_visual),
    })
  ),
  -- table
  s(
    { trig = 'tbl(%d+)x(%d+)', regTrig = true, snippetType = 'autosnippet' },
    d(1, generate_markdown_table),
    { condition = line_begin }
  ),
}
