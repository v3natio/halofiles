local function map(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " " -- leaderkey

map("n", ";", ":", { silent = false }) -- semicolon to enter command mode
map("n", ",p", '"0p') -- paste last yanked
map("n", ",P", '"0P') -- paste last yanked
map("n", "<c-k>", "<cmd>wincmd k<cr>") -- ctrl k to navigate splits
map("n", "<c-j>", "<cmd>wincmd j<cr>") -- ctrl j to navigate splits
map("n", "<c-h>", "<cmd>wincmd h<cr>") -- ctrl h to navigate splits
map("n", "<c-l>", "<cmd>wincmd l<cr>") -- ctrl l to navigate splits

map("n", "<leader>l", ":BufferLineCycleNext<cr>") -- move to right buffer
map("n", "<leader>h", ":BufferLineCyclePrev<cr>") -- move to left buffer

map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>") -- find old files
map("n", "<leader>.", "<cmd>Telescope find_files<cr>") -- find files
map("n", "<leader>f", "<cmd>Telescope current_buffer_fuzzy_find<cr>") --find in current buffer
map("n", "<leader>:", "<cmd>Telescope commands<cr>") -- find commands
map("n", "<leader>bb", "<cmd>Telescope buffers<cr>") -- find buffers

map("n", "<leader>o", ":setlocal spell! spelllang=en_us<CR>") -- toggle spellcheck
map("n", "<leader>oc", "z=") -- toggle spellcheck menu
map("n", "<leader>oa", "zg") -- add word to dictionary
map("n", "<leader>]", "]s") -- next spelling error
map("n", "<leader>[", "[s") -- previous spelling error

map("n", "<leader>1", ":e ~/Documents/Notes/Dashboard.md<cr>") -- go to my notes
map("n", "<leader>2", ":e ~/.config/nvim/lua/", {silent = false }) -- go to the neovim settings
map("n", "<leader>3", ":w! | :AsyncRun compiler '<c-r>%'<CR>") -- compile file
map("n", "<leader>4", ":!opout <c-r>%<CR><CR>") -- open compiled documents

map("n", "<F9>", ':AsyncRun g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<cr>') -- compile file
map("n", "<F5>", ':AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>') -- run file
map("n", "<F4>", ":AsyncRun -cwd=<root> make <cr>") -- build project
map("n", "<F8>", ":AsyncRun -cwd=<root> -raw make run <cr>") -- run project
map("n", "<F6>", ":AsyncRun -cwd=<root> -raw make test <cr>") -- run project test
map("n", "<F7>", ":AsyncRun -cwd=<root> cmake . <cr>") -- update makefile
map("n", "<F10>", ":call asyncrun#quickfix_toggle(6)<cr>") -- toggle quickfix window

-- Runs a script that cleans out tex build files whenever I close out of a .tex file.
vim.api.nvim_command("autocmd VimLeave *.tex !texclear %")

-- Packer lazyloading and autorun
vim.cmd "silent! command PackerCompile lua require 'pluginList' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'pluginList' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'pluginList' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'pluginList' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'pluginList' require('packer').update()"
