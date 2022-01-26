local options = {
  completeopt = { "menu", "menuone", "noselect", "noinsert" },
  undofile = true,
  swapfile = false,
  clipboard = "unnamedplus",
  fillchars = { eob = " " },
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
  signcolumn = "yes",
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
vim.api.nvim_command "autocmd VimLeave *.tex !vim_texclear %"

-- enable zen-mode for neomutt by default
vim.api.nvim_command "autocmd BufRead,BufNewFile /tmp/neomutt* :TZAtaraxis"

-- highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- set markdown filetypes
vim.cmd [[
  augroup SetMarkdownFt
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md,*.MD  set ft=markdown
  augroup end
]]

-- defer LSP and other packages
local M = {}
M.packer_lazy_load = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

-- toggle fold column
local toBool = {
  ["1"] = true,
  ["0"] = false,
}
M.toggleFoldCol = function()
  if toBool[vim.opt.foldcolumn:get()] then
    vim.opt.foldcolumn = "0"
  else
    vim.opt.foldcolumn = "1"
  end
  vim.api.nvim_echo({ { "foldcolumn is set to " .. vim.opt.foldcolumn:get() } }, false, {})
end
return M
