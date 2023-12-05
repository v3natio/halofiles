local helpers = require('snippets-helper')
local get_visual = helpers.get_visual
local clipboard_content = helpers.clipboard_content
local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {
  -- new chapter
  s(
    { trig = 'h1', snippetType = 'autosnippet' },
    fmta([[\nchapter{<>}{<>}]], {
      i(1, 'chapter'),
      d(2, get_visual),
    })
  ),
  -- new section
  s(
    { trig = 'h2', snippetType = 'autosnippet' },
    fmta([[\nsection{<>}{<>}{<>}]], {
      i(1, 'chapter'),
      i(2, 'section'),
      d(3, get_visual),
    })
  ),
  -- new subsection
  s(
    { trig = 'h3', snippetType = 'autosnippet' },
    fmta([[\nsubsection{<>}{<>}{<>}{<>}]], {
      i(1, 'chapter'),
      i(2, 'section'),
      i(3, 'subsection'),
      d(4, get_visual),
    })
  ),
  -- new item
  s({ trig = 'ii', snippetType = 'autosnippet' }, { t('\\item ') }, { condition = line_begin }),
  -- reference
  s(
    { trig = 'RR', snippetType = 'autosnippet', wordTrig = false },
    fmta(
      [[
      ~\ref{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- label
  s(
    { trig = 'lbl', snippetType = 'autosnippet' },
    fmta(
      [[
      \label{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- URL
  s(
    { trig = 'LL', snippetType = 'autosnippet' },
    fmta([[\href{<>}{<>}]], {
      f(clipboard_content, {}),
      d(1, get_visual),
    })
  ),
  -- horizontal space
  s(
    { trig = 'hss', snippetType = 'autosnippet' },
    fmta([[\hspace{<>}]], {
      d(1, get_visual),
    })
  ),
  -- vertical space
  s(
    { trig = 'vss', snippetType = 'autosnippet' },
    fmta([[\vspace{<>}]], {
      d(1, get_visual),
    })
  ),
}
