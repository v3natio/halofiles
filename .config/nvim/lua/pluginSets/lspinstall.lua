local present1, mason = pcall(require, 'mason')
local present2, mason_lspconfig = pcall(require, 'mason-lspconfig')
--local present3, mason_tool_installer = pcall(require, 'mason-tool-installer')

if not (present1 or present2) then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = '',
      package_pending = '',
      package_uninstalled = '',
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = {
    'bashls',
    'lua_ls',
    'marksman',
    'pyright',
  },
  automatic_installation = true,
})

--mason_tool_installer.setup({
--  ensure_installed = {
--    'black', -- python formatter
--    --'luacheck', -- lua linter
--    'prettier', -- general formatter
--    'pylint', -- python linter
--    'shellcheck', -- shell linter
--    'stylua', -- lua formatter
--  },
--})
