local present, telescope = pcall(require, 'telescope')
if not present then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
        ['<C-j>'] = require('telescope.actions').move_selection_next,
      },
    },
    prompt_prefix = '  ',
    layout_strategy = 'vertical',
    sorting_strategy = 'ascending',
    layout_config = {
      preview_cutoff = 5,
    },
  },
})

local extensions = { 'fzf' }
pcall(function()
  for _, ext in ipairs(extensions) do
    telescope.load_extension(ext)
  end
end)
