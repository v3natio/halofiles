local options = {
  completeopt = { 'menu', 'menuone', 'preview', 'noselect', 'noinsert' },
  undofile = true,
  swapfile = false,
  clipboard = 'unnamedplus',
  fillchars = { eob = ' ' },
  termguicolors = true,
  showmode = false,
  expandtab = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  shiftround = true,
  autoindent = true,
  linebreak = true,
  ignorecase = true,
  splitbelow = true,
  splitright = true,
  cursorline = true,
  signcolumn = 'yes',
  updatetime = 500,
  timeoutlen = 500,
  modelines = 0,
  maxmempattern = 2500,
  scrolloff = 8,
  breakindent = true,
  lazyredraw = true,
  number = true,
  relativenumber = true,
  numberwidth = 2,
  conceallevel = 1,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- clean .tex files when closing
vim.api.nvim_create_autocmd('VimLeavePre', {
  pattern = '*.tex',
  command = 'silent !latexmk -c %',
})

-- set latex filetype
vim.api.nvim_create_augroup('latex_filetype', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'latex_filetype',
  pattern = '*.tex',
  callback = function()
    vim.bo.filetype = 'latex'
    vim.wo.spell = true
  end,
})

-- set markdown filetype
vim.api.nvim_create_augroup('markdown_filetype', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'markdown_filetype',
  pattern = '*.md',
  callback = function()
    vim.bo.filetype = 'markdown'
    vim.opt.shiftwidth = 2
    vim.wo.spell = true
  end,
})

-- highlight on yank
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
  end,
})

-- install Mason packages
local mason_ensure_installed = {
  -- lsp
  'bash-language-server', -- bash
  'lua-language-server', -- lua
  'pyright', -- python
  -- formatters
  'black', -- python
  'shfmt', -- shell
  'stylua', -- lua
  -- linters
  'ruff', -- python
  'selene', -- lua
}
vim.api.nvim_create_user_command('MasonInstallAll', function()
  local packages = table.concat(mason_ensure_installed, ' ')
  vim.cmd('MasonInstall ' .. packages)
end, {})

local M = {}
-- toggle fold column
M.toggleFoldCol = function()
  local current = vim.opt.foldcolumn:get()
  local new_value = current == '1' and '0' or '1'
  vim.opt.foldcolumn = new_value
  vim.api.nvim_echo({ { 'foldcolumn is set to ' .. new_value } }, false, {})
end
return M
