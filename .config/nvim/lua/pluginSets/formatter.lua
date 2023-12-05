local present, conform = pcall(require, 'conform')
if not present then
  return
end

conform.setup({
  formatters_by_ft = {
    markdown = { 'prettier' },
    lua = { 'stylua' },
    python = { 'black' },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
})
