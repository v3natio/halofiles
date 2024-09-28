local present, gitsigns = pcall(require, 'gitsigns')
if not present then
  return
end

gitsigns.setup({
  signs = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '▁' },
    topdelete = { text = '▔' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
  numhl = true,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd('normal! ]c')
      else
        gitsigns.nav_hunk('next')
      end
    end)
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd('normal! [c')
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)
    map('n', '<leader>hd', gitsigns.diffthis)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)
  end,
})
