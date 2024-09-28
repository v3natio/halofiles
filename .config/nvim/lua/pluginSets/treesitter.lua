local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
end

treesitter.setup({
  ensure_installed = {
    'bash',
    'bibtex',
    'diff',
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'regex',
    'toml',
    'xml',
  },
  indent = { enable = true },
  highlight = { enable = true },
  playground = { enable = true },
})
