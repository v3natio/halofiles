local present, lint = pcall(require, 'lint')
if not present then
  return
end

lint.linters_by_ft = {
  lua = { 'selene' },
  python = { 'ruff' },
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    local client = vim.lsp.get_clients({ bufnr = 0 })[1] or {}
    lint.try_lint(nil, { cwd = client.root_dir or vim.fn.fnamemodify(vim.fn.finddir('.git', '.;'), ':h') })
  end,
})
