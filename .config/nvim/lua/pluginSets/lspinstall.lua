local present1, mason = pcall(require, 'mason')
local present2, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not (present1 or present2) then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = '',
      package_pending = '',
      package_uninstalled = '',
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = {
    'bashls',
    'lua_ls',
    'pyright',
    'taplo',
  },
  automatic_installation = true,
})
