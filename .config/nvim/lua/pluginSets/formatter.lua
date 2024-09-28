local present, conform = pcall(require, 'conform')
if not present then
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' },
    sh = { 'shfmt' },
  },
  format_on_save = {
    lsp_format = 'fallback',
  },
})

conform.formatters.shfmt = {
  command = 'shfmt',
  args = { '-i=2' },
}
