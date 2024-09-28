local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' ' -- leaderkey

map('n', ';', ':', { silent = false }) -- semicolon to enter command mode
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true }) -- word wrap
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true }) -- word wrap
map('n', 'U', '<cmd>redo<cr>') -- redo
map('n', ',p', '"0p') -- paste last yanked
map('x', 'p', [["_dP]]) -- paste without yanking replaced text
map('n', ',P', '"0P') -- paste last yanked
map('n', '<c-k>', '<cmd>wincmd k<cr>') -- ctrl k to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<cr>') -- ctrl j to navigate splits
map('n', '<c-h>', '<cmd>wincmd h<cr>') -- ctrl h to navigate splits
map('n', '<c-l>', '<cmd>wincmd l<cr>') -- ctrl l to navigate splits
map('n', 'gj', [[/^##\+ .*<CR>]]) -- jump to next markdown header
map('n', 'gk', [[?^##\+ .*<CR>]]) -- jump to previous markdown header
map('v', '<', '<gv') -- indent to the left
map('v', '>', '>gv') -- indent to the right
map('v', 'K', ':m .-2<CR>==') -- move text up
map('v', 'J', ':m .+1<CR>==') -- move text down
map('x', 'K', ":move '<-2<CR>gv-gv") -- move text up
map('x', 'J', ":move '>+1<CR>gv-gv") -- move text down

map('n', '<leader>tt', "<cmd>lua require'options'.toggleFoldCol()<CR>") -- toggle fold column
map('n', '<leader>nh', '<cmd>nohl<cr>') -- clear search
map('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- replace word under cursor

map('n', '<leader>l', '<cmd>bnext<cr>') -- move to right buffer
map('n', '<leader>h', '<cmd>bprevious<cr>') -- move to left buffer
map('n', '<leader>q', '<cmd>bd<cr>') -- close buffer

map('n', '<leader>fb', '<cmd>Telescope buffers<cr>') -- find buffers
map('n', '<leader>fc', '<cmd>Telescope commands<cr>') -- find commands
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>') -- find files
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>') -- find old files
map('n', '<leader>fs', '<cmd>Telescope live_grep<cr>') -- fuzzy find files

map('n', '<leader>s', '<cmd>setlocal spell! spelllang=en_us<CR>') -- toggle spellcheck
map('n', '<leader>sc', 'z=') -- toggle spellcheck menu
map('n', '<leader>sa', 'zg') -- add word to dictionary
map('n', '<leader>]', ']s') -- next spelling error
map('n', '<leader>[', '[s') -- previous spelling error

map('n', '<leader>1', '<cmd>e ~/documents/notes/zt/inbox/TODO.md<cr>') -- go to my notes
map('n', '<leader>2', ':e ~/.config/nvim/lua/', { silent = false }) -- go to the neovim settings
map('n', '<leader>3', ":w! | :AsyncRun vim_compile '<c-r>%'<CR>") -- compile documents
map('n', '<leader>4', ':!vim_output <c-r>%<CR><CR>') -- open compiled documents
