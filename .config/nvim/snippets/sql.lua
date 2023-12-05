local helpers = require('snippets-helper')
local get_visual = helpers.get_visual
local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {
  -- SELECT
  s({ trig = ';s', wordTrig = false, snippetType = 'autosnippet' }, { t('SELECT ') }),
  -- FROM
  s({ trig = ';f', wordTrig = false, snippetType = 'autosnippet' }, { t('FROM ') }),
  -- DISTINCT
  s({ trig = ';di', wordTrig = false, snippetType = 'autosnippet' }, { t('DISTINCT ') }),
  -- DROP
  s({ trig = ';dr', wordTrig = false, snippetType = 'autosnippet' }, { t('DROP ') }),
  -- WITH DELIMITER
  s({ trig = ';wd', wordTrig = false, snippetType = 'autosnippet' }, { t('WITH DELIMITER ') }),
  -- HEADER CSV
  s({ trig = ';hc', wordTrig = false, snippetType = 'autosnippet' }, { t('HEADER CSV ') }),
  -- CREATE TABLE
  s({ trig = ';ct', wordTrig = false, snippetType = 'autosnippet' }, { t('CREATE TABLE ') }),
  -- CREATE TEMPORARY TABLE
  s({ trig = ';cp', wordTrig = false, snippetType = 'autosnippet' }, { t('CREATE TEMPORARY TABLE ') }),
  -- UPDATE
  s({ trig = ';u', wordTrig = false, snippetType = 'autosnippet' }, { t('UPDATE ') }),
  -- NULL
  s({ trig = ';nl', wordTrig = false, snippetType = 'autosnippet' }, { t('NULL ') }),
  -- NOT NULL
  s({ trig = ';nn', wordTrig = false, snippetType = 'autosnippet' }, { t('NOT NULL ') }),
}
