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
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- clean .tex files when closing
vim.api.nvim_create_autocmd('VimLeavePre', {
  pattern = '*.tex',
  command = 'silent !vim_texclear %',
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

-- highlight on yank
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
  end,
})

local M = {}
-- toggle fold column
local toBool = {
  ['1'] = true,
  ['0'] = false,
}
M.toggleFoldCol = function()
  if toBool[vim.opt.foldcolumn:get()] then
    vim.opt.foldcolumn = '0'
  else
    vim.opt.foldcolumn = '1'
  end
  vim.api.nvim_echo({ { 'foldcolumn is set to ' .. vim.opt.foldcolumn:get() } }, false, {})
end

-- Function to open markdown links
M.openMarkdownLink = function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  -- matches the markdown link syntax
  local pattern = '%[(.-)%]%((.-)%)'
  for text, link in line:gmatch(pattern) do
    local startText, endText = line:find('%[' .. text .. '%]')
    local startLink, endLink = line:find('%(' .. link .. '%)')
    if col >= startText and col <= endLink then
      vim.fn.system('vim_links ' .. link)
      return
    end
  end
end
return M
