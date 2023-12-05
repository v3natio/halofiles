local present1, lspconfig = pcall(require, 'lspconfig')
local present2, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not (present1 or present2) then
  return
end

-- passes autocompletion to cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- set the keymaps for LSP
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
end

local on_attach = function(client, bufnr)
  map('n', 'gR', '<cmd>Telescope lsp_references<CR>') -- show all references
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>') -- jump to declaration
  map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>') -- show all definitions
  map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>') -- show LSP implementations
  map('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>') -- show LSP type definitions
  map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- see available code actions
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>') -- smart rename
  map('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>') -- show diagnistics for current file
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>') -- jump to previous diagnostic in buffer
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>') -- jump to next diagnostic in buffer
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>') -- show documentation
  map('n', '<leader>rs', ':LspRestart<CR>') -- restart LSP server
end

-- configure LSP servers
-- bash server
lspconfig['bashls'].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-- lua server
lspconfig['lua_ls'].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      -- make the language server recognize 'vim' global
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
      },
    },
  },
})
-- markdown server
lspconfig['marksman'].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- python server
lspconfig['pyright'].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        diagnosticMode = 'workspace',
      },
    },
  },
})

-- replace the default LSP diagnostic symbols
local function lspSymbol(name, icon)
  vim.fn.sign_define(name, { texthl = name, text = icon, numhl = '' })
end
lspSymbol('DiagnosticSignError', '')
lspSymbol('DiagnosticSignWarn', '')
lspSymbol('DiagnosticSignHint', '')
lspSymbol('DiagnosticSignInfo', '')
