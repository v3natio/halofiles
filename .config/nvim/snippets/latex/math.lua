local helpers = require('snippets-helper')
local ts_helpers = require('snippets-treesitter')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin
local in_text = ts_helpers.in_text
local in_mathzone = ts_helpers.in_mathzone

return {
  -- superscript
  s(
    { trig = "([%w%)%]%}])'", regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- superscript shortcut
  s(
    { trig = '([%w%)%]%}])"([%w])', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- subscript
  s(
    { trig = '([%w%)%]%}]);', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- subscript shortcut
  s(
    { trig = '([%w%)%]%}]):([%w])', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- subscript and superscript
  s(
    { trig = '([%w%)%]%}])__', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>^{<>}_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- overline
  s(
    { trig = '(%a+)bar', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\overline{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- over rightarrow
  s(
    { trig = '(%a+)ora', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\overrightarrow{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- over leftarrrow
  s(
    { trig = '(%a+)ola', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\overleftarrow{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- ring
  s(
    { trig = '(%a+)ring', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\mathring{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- hat
  s(
    { trig = '(%a+)hat', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\hat{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- pending substitution
  s(
    { trig = '([^%a])psb', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\bigg\\rvert_{\\substack{<>}}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = in_mathzone }
  ),
  -- angle
  s(
    { trig = '(%a+)gg', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\ang{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- vector
  s(
    { trig = '(%a+)vv', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\vec{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- fraction
  s(
    { trig = '([^%a])ff', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\frac{<>}{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- absolute value
  s(
    { trig = '([^%a])aa', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\lvert <> \\rvert', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- norm
  s(
    { trig = '([^%a])AA', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\lVert <> \\rVert', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- square root
  s(
    { trig = '([^%\\])sq', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\sqrt{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- binomial
  s(
    { trig = '([^%\\])bnn', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\binom{<>}{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- logarithm
  s(
    { trig = '([^%a%\\])ll', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\log_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = in_mathzone }
  ),
  -- limit
  s(
    { trig = '([^%\\])lmm', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\lim_{<> \\to <>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- limit (two variables)
  s(
    { trig = '([^%\\])lMM', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\lim_{(<>, <>) \\to (<>, <>)}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
      i(4),
    }),
    { condition = in_mathzone }
  ),
  -- derivative
  s(
    { trig = '([^%a])dvv', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\frac{\\mathrm{d} <>}{\\mathrm{d} <>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- derivative (with higher order)
  s(
    { trig = '([^%a])ddv', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\frac{\\mathrm{d}^{<>} <>}{\\mathrm{d} <>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
    }),
    { condition = in_mathzone }
  ),
  -- partial derivative
  s(
    { trig = '([^%a])pvv', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\frac{\\partial <>}{\\partial <>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- partial derivative (with higher order)
  s(
    { trig = '([^%a])ppv', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\frac{\\partial^{<>} <>}{\\partial <>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
    }),
    { condition = in_mathzone }
  ),
  -- matrix
  s(
    { trig = 'mtt', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{pmatrix}
          <>
        \end{pmatrix}
      ]],
      {
        i(1),
      }
    ),
    { condition = in_mathzone }
  ),
  -- sum
  s(
    { trig = '([^%a])smm', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\sum_{<>}^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- product
  s(
    { trig = '([^%a])prr', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\prod_{<>}^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- integral
  s(
    { trig = '([^%a])intt', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\int_{<>}^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- integral (positive/negative inf)
  s(
    { trig = '([^%a])intf', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\int_{\\infty}^{\\infty}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  --------------------------
  --      OPERATORS
  --------------------------
  -- infinity
  s({ trig = 'inff', snippetType = 'autosnippet' }, {
    t('\\infty'),
  }, { condition = in_mathzone }),
  -- gradient
  s({ trig = 'gdd', snippetType = 'autosnippet' }, {
    t('\\nabla '),
  }, { condition = in_mathzone }),
  -- parallel
  s({ trig = '||', snippetType = 'autosnippet' }, {
    t('\\parallel'),
  }, { condition = in_mathzone }),
  -- set minus
  s({ trig = 'stm', snippetType = 'autosnippet' }, {
    t('\\setminus '),
  }, { condition = in_mathzone }),
  -- subset
  s({ trig = 'sbb', snippetType = 'autosnippet' }, {
    t('\\subset '),
  }, { condition = in_mathzone }),
  -- union
  s({ trig = 'cup', snippetType = 'autosnippet' }, {
    t('\\cup '),
  }, { condition = in_mathzone }),
  -- intersection
  s({ trig = 'cap', snippetType = 'autosnippet' }, {
    t('\\cap '),
  }, { condition = in_mathzone }),
  -- in
  s({ trig = 'inn', snippetType = 'autosnippet' }, {
    t('\\in '),
  }, { condition = in_mathzone }),
  -- not in
  s({ trig = 'notin', snippetType = 'autosnippet' }, {
    t('\\notin '),
  }, { condition = in_mathzone }),
  -- centered dots
  s({ trig = 'cdd', snippetType = 'autosnippet' }, {
    t('\\cdots'),
  }, { condition = in_mathzone }),
  -- lowered dots
  s({ trig = 'ldd', snippetType = 'autosnippet' }, {
    t('\\ldots'),
  }, { condition = in_mathzone }),
  -- diagonal dots
  s({ trig = 'ddd', snippetType = 'autosnippet' }, {
    t('\\ddots'),
  }, { condition = in_mathzone }),
  -- vertical dots
  s({ trig = 'vdd', snippetType = 'autosnippet' }, {
    t('\\vdots'),
  }, { condition = in_mathzone }),
  -- equivalent
  s({ trig = 'eqq', snippetType = 'autosnippet' }, {
    t('\\equiv '),
  }, { condition = in_mathzone }),
  -- approximate
  s({ trig = 'px', snippetType = 'autosnippet' }, {
    t('\\approx '),
  }, { condition = in_mathzone }),
  -- proprtional
  s({ trig = 'pt', snippetType = 'autosnippet' }, {
    t('\\propto '),
  }, { condition = in_mathzone }),
  -- implies
  s({ trig = '>>', snippetType = 'autosnippet' }, {
    t('\\implies '),
  }, { condition = in_mathzone }),
  -- implied by
  s({ trig = '<<', snippetType = 'autosnippet' }, {
    t('\\impliedby '),
  }, { condition = in_mathzone }),
  -- dot product
  s({ trig = ',.', snippetType = 'autosnippet' }, {
    t('\\cdot '),
  }, { condition = in_mathzone }),
  -- cross product
  s({ trig = 'xx', snippetType = 'autosnippet' }, {
    t('\\times '),
  }, { condition = in_mathzone }),
  -- for which
  s({ trig = 'which', snippetType = 'autosnippet' }, {
    t('\\text{ for which } '),
  }, { condition = in_mathzone }),
  -- for all
  s({ trig = 'frll', snippetType = 'autosnippet' }, {
    t('\\text{ for all } '),
  }, { condition = in_mathzone }),
}
