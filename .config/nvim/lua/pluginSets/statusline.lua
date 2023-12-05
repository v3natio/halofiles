local present, lualine = pcall(require, 'lualine')
if not present then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn', 'hint', 'info' },
  symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
  colored = false,
  update_in_insert = true,
  always_visible = false,
}

local diff = {
  'diff',
  colored = false,
  symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  'mode',
  fmt = function(str)
    return '-- ' .. str .. ' --'
  end,
}

local filename = {
  'filename',
  symbols = {
    modified = ' ',
    readonly = ' ',
    unnamed = ' ',
  },
}

local filetype = {
  'filetype',
  colored = false,
  icons_enabled = true,
  icon = nil,
}

local branch = {
  'branch',
  icons_enabled = true,
  icon = '',
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'dashboard', 'NvimTree', 'Outline' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, diagnostics },
    lualine_b = { mode },
    lualine_c = { filename },
    lualine_x = { diff, filetype },
    lualine_y = {},
    lualine_z = { 'progress' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
