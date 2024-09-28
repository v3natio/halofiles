local present1, lspconfig = pcall(require, 'lspconfig')
local present2, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not (present1 or present2) then
  return
end

-- passes autocompletion to cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- passes hover UI to the buffer
local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

-- replace the default LSP diagnostic symbols
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- set the keymaps for LSP
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
end

local on_attach = function(_, bufnr)
  map('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>') -- show all references
  map('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>') -- show all definitions
  map('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- see available code actions
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>') -- smart rename
  map('n', '<leader>gD', '<cmd>Telescope diagnostics bufnr=0<CR>') -- show diagnistics for current file
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>') -- jump to previous diagnostic in buffer
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>') -- jump to next diagnostic in buffer
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>') -- show documentation
  map('n', '<leader>rs', ':LspRestart<CR>') -- restart LSP server

  -- replace in-line diagnostics with floating window
  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        border = 'rounded',
        source = 'if_many',
        header = false,
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.config({ virtual_text = false })
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end

-- configure LSP servers
-- bash server
lspconfig['bashls'].setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
-- lua server
lspconfig['lua_ls'].setup({
  capabilities = capabilities,
  handlers = handlers,
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
-- python server
lspconfig['pyright'].setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        diagnosticMode = 'workspace',
      },
    },
  },
})
-- toml server
lspconfig['taplo'].setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern('.taplo.toml'),
})
