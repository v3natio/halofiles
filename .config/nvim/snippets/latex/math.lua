local helpers = require('snippets-helper')
local ts_helpers = require('snippets-treesitter')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin
local in_text = ts_helpers.in_text
local in_mathzone = ts_helpers.in_mathzone

-- function to dynamically generate matrix content
local generate_matrix = function(args, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local ins_indx = 1

  for j = 1, rows do
    table.insert(nodes, t('  ')) -- indent
    table.insert(nodes, r(ins_indx, tostring(j) .. 'x1', i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(' & '))
      table.insert(nodes, r(ins_indx, tostring(j) .. 'x' .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    -- add line break (\\) if not in last row
    if j < rows then
      table.insert(nodes, t({ ' \\\\', '' }))
    else
      table.insert(nodes, t(''))
    end
  end

  return sn(nil, nodes)
end

return {
  -- math line end
  s({ trig = 'br', snippetType = 'autosnippet' }, { t('\\\\') }, { condition = in_mathzone }),
  -- fraction
  s(
    { trig = '([^%a%\\])ff', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\frac{<>}{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- square root
  s(
    { trig = '([^%a%\\])sq', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\sqrt{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- natural logarithm
  s(
    { trig = '([^%a%\\])ln', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\ln(<>)', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = in_mathzone }
  ),
  -- superscript
  s(
    { trig = "([%w%)%]%}])''", regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- subscript
  s(
    { trig = '([%w%)%]%}]);;', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- overline
  s(
    { trig = '([%w\\]+)bar', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\overline{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- ring
  s(
    { trig = '([%w\\]+)ring', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\mathring{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- hat
  s(
    { trig = '([%w\\]+)hat', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\hat{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- wide hat
  s(
    { trig = '([%w\\]+)Hat', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\widehat{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- tilde
  s(
    { trig = '([%w\\]+)tld', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\tilde{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- wide tilde
  s(
    { trig = '([%w\\]+)Tld', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\widetilde{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- dot
  s(
    { trig = '([%w\\]+)dot', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\dot{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- two dots
  s(
    { trig = '([%w\\]+)Dot', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\ddot{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- angle
  s(
    { trig = '(%d+)gg', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\ang{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- inner product
  s(
    { trig = '([^%a%\\])la', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\left\\langle <> \\right\\rangle', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- vector
  s(
    { trig = '([%w\\]+)vv', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\vec{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- over rightarrow
  s(
    { trig = '([%w\\]+)orr', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\overrightarrow{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- over leftarrrow
  s(
    { trig = '([%w\\]+)olr', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\overleftarrow{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- absolute value
  s(
    { trig = '([^%a%\\])aa', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\left\\lvert <> \\right\\rvert', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- norm
  s(
    { trig = '([^%a%\\])AA', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\left\\lVert <> \\right\\rVert', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- pending substitution
  s(
    { trig = '([^%a%\\])psb', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\bigg\\rvert_{\\substack{<>}}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = in_mathzone }
  ),
  -- evaluated at
  s(
    { trig = '([^%a%\\])evl', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\bigg\\rvert^{\\substack{<>}}_{\\substack{<>}}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- underbrace
  s(
    { trig = 'ubr', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\underbrace{<>}_{<>}', {
      d(1, get_visual),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- overbrace
  s(
    { trig = 'ovr', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\overbrace{<>}^{<>}', {
      d(1, get_visual),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- translated to
  s(
    { trig = '([^%a%\\])trl', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\xrightarrow{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = in_mathzone }
  ),
  -- boxed
  s(
    { trig = 'bxd', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\boxed{<>}', {
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- text color
  s(
    { trig = 'tc', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\textcolor{<>}{<>}', {
      i(1),
      d(2, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- regular text (in mathmode)
  s(
    { trig = 'tee', snippetType = 'autosnippet' },
    fmta('<>\\text{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- matrix
  s(
    { trig = '([vp])mt(%d+)x(%d+)', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{<>matrix}
        <>
        \end{<>matrix}
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        d(1, generate_matrix),
        f(function(_, snip)
          return snip.captures[1]
        end),
      }
    ),
    { condition = in_mathzone }
  ),
  -- sum
  s(
    { trig = '([^%a%\\])smm', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
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
    { trig = '([^%a%\\])prr', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\prod_{<>}^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- binomial
  s(
    { trig = '([^%a%\\])bnn', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\binom{<>}{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = in_mathzone }
  ),
  -- limit
  s(
    { trig = '([^%a%\\])lmm', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
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
    { trig = '([^%a%\\])lMM', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
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
    { trig = '([^%a%\\])ddv', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
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
    { trig = '([^%a%\\])ddV', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
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
    { trig = '([^%a%\\])pdv', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
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
    { trig = '([^%a%\\])pdV', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
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
  -- integral
  s(
    { trig = '([^%a%\\])intt', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
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
    { trig = '([^%a%\\])intf', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\int_{-\\infty}^{\\infty}', {
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
    t('\\nabla'),
  }, { condition = in_mathzone }),
  -- not equal to
  s({ trig = '-=', snippetType = 'autosnippet' }, {
    t('\\ne '),
  }, { condition = in_mathzone }),
  -- equivalent
  s({ trig = 'eqq', snippetType = 'autosnippet' }, {
    t('\\equiv '),
  }, { condition = in_mathzone }),
  -- approximate
  s({ trig = 'pxx', snippetType = 'autosnippet' }, {
    t('\\approx '),
  }, { condition = in_mathzone }),
  -- approximately equal to
  s({ trig = 'pxq', snippetType = 'autosnippet' }, {
    t('\\approxeq '),
  }, { condition = in_mathzone }),
  -- less than or equal to
  s({ trig = 'lee', snippetType = 'autosnippet' }, {
    t('\\le '),
  }, { condition = in_mathzone }),
  -- approximately less than
  s({ trig = 'leq', snippetType = 'autosnippet' }, {
    t('\\lesssim '),
  }, { condition = in_mathzone }),
  -- much less than
  s({ trig = 'll', snippetType = 'autosnippet' }, {
    t('\\ll '),
  }, { condition = in_mathzone }),
  -- greater than or equal to
  s({ trig = 'gee', snippetType = 'autosnippet' }, {
    t('\\ge '),
  }, { condition = in_mathzone }),
  -- approximately greater than
  s({ trig = 'geq', snippetType = 'autosnippet' }, {
    t('\\gtrsim '),
  }, { condition = in_mathzone }),
  -- much greater than
  s({ trig = 'gg', snippetType = 'autosnippet' }, {
    t('\\gg '),
  }, { condition = in_mathzone }),
  -- proprtional
  s({ trig = 'pt', snippetType = 'autosnippet' }, {
    t('\\propto '),
  }, { condition = in_mathzone }),
  -- fits a
  s({ trig = 'sim', snippetType = 'autosnippet' }, {
    t('\\sim '),
  }, { condition = in_mathzone }),
  -- implies
  s({ trig = '>>', snippetType = 'autosnippet' }, {
    t('\\implies '),
  }, { condition = in_mathzone }),
  -- implied by
  s({ trig = '<<', snippetType = 'autosnippet' }, {
    t('\\impliedby '),
  }, { condition = in_mathzone }),
  -- mutually implied
  s({ trig = 'iff', snippetType = 'autosnippet' }, {
    t('\\iff '),
  }, { condition = in_mathzone }),
  -- up arrow
  s({ trig = 'urr', snippetType = 'autosnippet' }, {
    t('\\uparrow '),
  }, { condition = in_mathzone }),
  -- down arrow
  s({ trig = 'drr', snippetType = 'autosnippet' }, {
    t('\\downarrow '),
  }, { condition = in_mathzone }),
  -- to
  s({ trig = 'to', snippetType = 'autosnippet' }, {
    t('\\to '),
  }, { condition = in_mathzone }),
  -- into
  s({ trig = 'into', snippetType = 'autosnippet' }, {
    t('\\curvearrowright '),
  }, { condition = in_mathzone }),
  -- maps to
  s({ trig = 'mto', snippetType = 'autosnippet' }, {
    t('\\mapsto '),
  }, { condition = in_mathzone }),
  -- dot product
  s({ trig = ',.', snippetType = 'autosnippet' }, {
    t('\\cdot '),
  }, { condition = in_mathzone }),
  -- cross product
  s({ trig = 'xx', snippetType = 'autosnippet' }, {
    t('\\times '),
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
  -- parallel
  s({ trig = '||', snippetType = 'autosnippet' }, {
    t('\\parallel '),
  }, { condition = in_mathzone }),
  -- perpendicular
  s({ trig = 'perp', snippetType = 'autosnippet' }, {
    t('\\perp '),
  }, { condition = in_mathzone }),
  -- set minus
  s({ trig = 'stm', snippetType = 'autosnippet' }, {
    t('\\setminus '),
  }, { condition = in_mathzone }),
  -- subset
  s({ trig = 'sbb', snippetType = 'autosnippet' }, {
    t('\\subset '),
  }, { condition = in_mathzone }),
  -- subset or equal to
  s({ trig = 'sbq', snippetType = 'autosnippet' }, {
    t('\\subseteq '),
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
  -- for which
  s({ trig = 'which', snippetType = 'autosnippet' }, {
    t('\\text{ for which } '),
  }, { condition = in_mathzone }),
  -- such that
  s({ trig = 'stt', snippetType = 'autosnippet' }, {
    t('\\text{ s.t. } '),
  }, { condition = in_mathzone }),
  -- for all
  s({ trig = 'forall', snippetType = 'autosnippet' }, {
    t('\\forall '),
  }, { condition = in_mathzone }),
  -- exists
  s({ trig = 'exists', snippetType = 'autosnippet' }, {
    t('\\exists '),
  }, { condition = in_mathzone }),
  -- doesn't exist
  s({ trig = 'nexists', snippetType = 'autosnippet' }, {
    t('\\nexists '),
  }, { condition = in_mathzone }),
}
