local M = {}

M.colorizer = function()
  local present, colorizer = pcall(require, 'colorizer')
  if present then
    colorizer.setup({ '*' }, {
      RGB = true,
      RRGGBB = true,
      mode = 'background',
    })
    vim.cmd('ColorizerReloadAllBuffers')
  end
end

M.luasnip = function()
  local present, luasnip = pcall(require, 'luasnip')
  if present then
    luasnip.setup({
      enable_autosnippets = true,
    })
    require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/snippets' })
  end
end

M.neogit = function()
  local present, neogit = pcall(require, 'neogit')
  if present then
    neogit.setup({
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      signs = {
        section = { '', '' },
        item = { '', '' },
        hunk = { '', '' },
      },
      integrations = {
        diffview = true,
      },
    })
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
return M
