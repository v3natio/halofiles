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
  symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
  update_in_insert = true,
}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local diff = {
  'diff',
  source = diff_source,
  symbols = { added = ' ', modified = ' ', removed = ' ' },
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
    modified = ' ',
    readonly = ' ',
    unnamed = ' ',
  },
}

local branch = {
  'b:gitsigns_head',
  icon = '',
}

lualine.setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diagnostics },
    lualine_c = { filename },
    lualine_x = { diff },
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
})
