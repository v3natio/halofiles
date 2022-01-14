vim.opt.shortmess:append "casI"
vim.opt.whichwrap:append "<>hl"
require "pluginSets.statusline"
vim.opt.fillchars = { eob = " " }
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.mouse = "n"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 500
vim.opt.timeoutlen = 500
vim.opt.clipboard = "unnamedplus"
vim.opt.modelines = 0
vim.opt.maxmempattern = 2500
vim.opt.scrolloff = 8
vim.opt.breakindent = true
vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.linebreak = true

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
return M
