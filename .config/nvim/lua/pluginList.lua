return {
  -- General
  {
    'nvim-treesitter/nvim-treesitter', -- neovim parser
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {},
    config = function()
      require('pluginSets.treesitter')
    end,
  },
  {
    'hrsh7th/nvim-cmp', -- completion engine
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip', -- snippet engine
        version = 'v2.*',
        build = 'make install_jsregexp',
        config = function()
          require('pluginSets.others').luasnip()
        end,
      },
      'saadparwaiz1/cmp_luasnip', -- snippet completion
      'hrsh7th/cmp-nvim-lua', -- lua completion
      'hrsh7th/cmp-nvim-lsp', -- LSP completion
      'hrsh7th/cmp-path', -- path completion
    },
    config = function()
      require('pluginSets.cmp')
    end,
  },

  -- Development
  {
    'skywind3000/asyncrun.vim', -- asyncronous command runner
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.g.asyncrun_open = 3
      vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', '_darcs' }
    end,
  },
  {
    'williamboman/mason.nvim', -- utilities installer
    lazy = true,
    dependencies = 'williamboman/mason-lspconfig.nvim', -- LSP setup
    config = function()
      require('pluginSets.lspinstall')
    end,
  },
  {
    'neovim/nvim-lspconfig', -- LSP
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = 'mason.nvim',
    config = function()
      require('pluginSets.lspconfig')
    end,
  },
  {
    'stevearc/conform.nvim', -- formatter setup
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('pluginSets.formatter')
    end,
  },
  {
    'mfussenegger/nvim-lint', -- linter setup
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('pluginSets.linter')
    end,
  },
  {
    'lewis6991/gitsigns.nvim', -- diff highligher
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('pluginSets.gitsigns')
    end,
  },
  {
    'TimUntersberger/neogit', -- git UI
    cmd = {
      'Neogit',
    },
    dependencies = 'sindrets/diffview.nvim', -- diff handler
    config = function()
      require('pluginSets.others').neogit()
    end,
  },
  {
    'norcalli/nvim-colorizer.lua', -- HEX color highlighter
    cmd = 'ColorizerToggle',
    config = function()
      require('pluginSets.others').colorizer()
    end,
  },
  {
    'nvim-telescope/telescope.nvim', -- fuzzy finder
    branch = '0.1.x',
    cmd = 'Telescope',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim' },
      { 'nvim-lua/plenary.nvim', build = 'make' },
    },
    config = function()
      require('pluginSets.telescope')
    end,
  },

  -- Writting
  {
    'bamonroe/rnoweb-nvim', -- LaTeX symbol folding
    event = 'VeryLazy',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('pluginSets.others').rnoweb()
    end,
  },

  -- Eye-candy
  {
    'eddyekofo94/gruvbox-flat.nvim', -- colorscheme
    priority = 1000,
    config = function()
      vim.g.gruvbox_transparent = true
      vim.cmd('colorscheme gruvbox-flat')
    end,
  },
  {
    'nvim-lualine/lualine.nvim', -- status bar
    config = function()
      require('pluginSets.statusline')
    end,
  },
  {
    'stevearc/dressing.nvim', -- prettier code action menu
    lazy = true,
    event = 'InsertEnter',
  },
  {
    'lukas-reineke/indent-blankline.nvim', -- indent indicator
    event = 'VeryLazy',
    config = function()
      require('pluginSets.others').indent()
    end,
  },
}
