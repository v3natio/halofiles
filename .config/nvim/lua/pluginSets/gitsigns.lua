local present, gitsigns = pcall(require, 'gitsigns')
if not present then
  return
end

gitsigns.setup({
  signs = {
    add = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '▁', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '▔', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.actions.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.actions.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('v', '<leader>hs', function()
      gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hr', function()
      gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function()
      gs.blame_line(true)
    end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hU', gs.reset_buffer_index)

    -- Text object
    map('o', 'ih', ':<C-U>gs.actions.select_hunk()<CR>')
    map('x', 'ih', ':<C-U>gs.actions.select_hunk()<CR>')
  end,
  watch_gitdir = {
    interval = 1000,
  },
  current_line_blame = false,
  sign_priority = 5,
  update_debounce = 500,
  status_formatter = nil,
  diff_opts = {
    internal = true,
  },
})
