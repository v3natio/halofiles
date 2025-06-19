local M = {}

M.colorizer = function()
  local present, colorizer = pcall(require, 'colorizer')
  if present then
    colorizer.setup({ '*' }, {})
    vim.cmd('ColorizerReloadAllBuffers')
  end
end

M.luasnip = function()
  local present, luasnip = pcall(require, 'luasnip')
  if present then
    luasnip.setup({
      enable_autosnippets = true,
      store_selection_keys = '<Tab>',
    })
    require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/snippets' })
  end
end

M.indent = function()
  local present, ibl = pcall(require, 'ibl')
  if present then
    ibl.setup({
      indent = { char = '|', tab_char = '|' },
      scope = { enabled = false },
    })
  end
end

M.rnoweb = function()
  local present, rnoweb = pcall(require, 'rnoweb-nvim')
  if present then
    rnoweb.setup()
  end
end

M.gruvbox = function()
  local present, gruvbox = pcall(require, 'gruvbox')
  if present then
    gruvbox.setup({
      transparent_mode = true,
      palette_overrides = {
        dark0 = '#282828',
        dark1 = '#3c3836',
        dark2 = '#504945',
        dark3 = '#665c54',
        dark4 = '#7c6f64',
        light0 = '#fbf1c7',
        light1 = '#f4e8be',
        light2 = '#f2e5bc',
        light3 = '#eee0b7',
        light4 = '#e5d5ad',
        bright_red = '#ea6962',
        bright_green = '#a9b665',
        bright_yellow = '#d8a657',
        bright_blue = '#7daea3',
        bright_purple = '#d3869b',
        bright_aqua = '#89b482',
        bright_orange = '#e78a4e',
        neutral_red = '#cc241d',
        neutral_green = '#98971a',
        neutral_yellow = '#d79921',
        neutral_blue = '#458588',
        neutral_purple = '#b16286',
        neutral_aqua = '#689d6a',
        neutral_orange = '#d65d0e',
        dark_red = '#722529',
        dark_green = '#62693e',
        dark_aqua = '#49503b',
        gray = '#928374',
        faded_red = '#c14a4a',
        faded_green = '#6c782e',
        faded_yellow = '#647109',
        faded_blue = '#45707a',
        faded_purple = '#945e80',
        faded_aqua = '#4c7a5d',
        faded_orange = '#c35e0a',
        light_red = '#ae5858',
        light_green = '#ebeabc',
        light_aqua = '#dee2b6',
      },
    })
    vim.o.background = 'dark'
    vim.cmd('colorscheme gruvbox')
  end
end
return M
