local present, obsidian = pcall(require, 'obsidian')
if not present then
  return
end

obsidian.setup({
  workspaces = {
    {
      name = 'notes',
      path = '~/documents/notes/',
      overrides = {
        notes_subdir = 'zt/inbox',
      },
    },
  },
  disable_frontmatter = true,
  templates = {
    folder = 'templates',
    date_format = '%Y-%m-%d',
    time_format = '%H:%M',
  },
  image_name_func = function()
    return string.format('%s-', os.time())
  end,
  attachments = {
    img_folder = 'files',
  },
  mappings = {
    ['gf'] = {
      action = function()
        return obsidian.util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    ['<leader>bq'] = {
      action = function()
        return obsidian.util.smart_action()
      end,
      opts = { expr = true, buffer = true },
    },
    ['<leader>bi'] = {
      action = '<cmd>ObsidianPasteImg<cr>',
      opts = { buffer = true },
    },
    ['<leader>bs'] = {
      action = '<cmd>ObsidianSearch<cr>',
      opts = { buffer = true },
    },
    ['<leader>bt'] = {
      action = '<cmd>ObsidianTemplate<cr>',
      opts = { buffer = true },
    },
    ['<leader>bf'] = {
      action = '<cmd>s/\\(# \\)[^_]*_/\\1/ | s/-/ /g | nohlsearch<cr>',
      opts = { buffer = true },
    },
  },
  ui = {
    checkboxes = {
      [' '] = { char = '', hl_group = 'ObsidianTodo' },
      ['x'] = { char = '󰄬', hl_group = 'ObsidianDone' },
      ['>'] = { char = '󰅂', hl_group = 'ObsidianRightArrow' },
      ['~'] = { char = '󰅖', hl_group = 'ObsidianTilde' },
      ['!'] = { char = '󰈅', hl_group = 'ObsidianImportant' },
    },
    bullets = { char = '', hl_group = 'ObsidianBullet' },
    external_link_icon = { char = '󰏢', hl_group = 'ObsidianExtLinkIcon' },
    hl_groups = {
      ObsidianTodo = { bold = true, fg = '#fb4934' },
      ObsidianDone = { bold = true, fg = '#458588' },
      ObsidianRightArrow = { bold = true, fg = '#fb4934' },
      ObsidianTilde = { bold = true, fg = '#fe8019' },
      ObsidianImportant = { bold = true, fg = '#cc241d' },
      ObsidianBullet = { bold = true, fg = '#458588' },
      ObsidianRefText = { underline = true, fg = '#b16286' },
      ObsidianExtLinkIcon = { fg = '#b16286' },
      ObsidianTag = { italic = true, fg = '#458588' },
      ObsidianBlockID = { italic = true, fg = '#458588' },
      ObsidianHighlightText = { bg = '#d79921' },
    },
  },
})
