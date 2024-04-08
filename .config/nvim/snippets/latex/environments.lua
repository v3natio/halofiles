local helpers = require('snippets-helper')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {
  -- generic
  s(
    { trig = 'new', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
  -- itemize
  s(
    { trig = 'itt', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{itemize}
          \item <>
        \end{itemize}
      ]],
      {
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  -- enumerate
  s(
    { trig = 'enn', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{enumerate}
          \item <>
        \end{enumerate}
      ]],
      {
        i(0),
      }
    )
  ),
  -- inline math
  s(
    { trig = 'mm', snippetType = 'autosnippet' },
    fmta('$<>$', {
      i(1),
    })
  ),
  -- aligned equation
  s(
    { trig = 'all', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{align*}
          <>
        \end{align*}
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- equation
  s(
    { trig = 'nn', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{equation*}
          <>
        \end{equation*}
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
        \begin{equation*}
          \begin{split}
            <>
          \end{split}
        \end{equation*}
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
        \begin{equation*}
          \begin{cases}
            <>
          \end{cases}
        \end{equation*}
      ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- proposition
  s(
    { trig = 'npro', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{prop}
          <>
        \end{prop}
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),

  -- definition
  s(
    { trig = 'ndef', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{definition}
          <>
        \end{definition}
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),

  -- remark
  s(
    { trig = 'nrem', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{remark}
          <>
        \end{remark}
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- figure
  s(
    { trig = 'img' },
    fmta(
      [[
        \begin{figure}[H]
          \centering
          \incfig{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
      ]],
      {
        i(1, 'name'),
        i(2, 'caption'),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
}
