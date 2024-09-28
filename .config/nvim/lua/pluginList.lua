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
    event = { 'InsertEnter' },
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
    cmd = 'AsyncRun',
    config = function()
      vim.g.asyncrun_open = 3
      vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', '_darcs' }
    end,
  },
  {
    'neovim/nvim-lspconfig', -- LSP
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('pluginSets.lspconfig')
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim', -- LSP setup
      dependencies = {
        'williamboman/mason.nvim', -- utilities installer
        config = function()
          require('pluginSets.lspinstall')
        end,
      },
    },
  },
  {
    'stevearc/conform.nvim', -- formatter setup
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('pluginSets.formatter')
    end,
  },
  {
    'mfussenegger/nvim-lint', -- linter setup
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
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require('pluginSets.telescope')
    end,
  },

  -- Writting
  {
    'epwalsh/obsidian.nvim', -- Obsidian note-taking
    version = '*',
    ft = 'markdown',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('pluginSets.obsidian')
    end,
  },
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
    'ellisonleao/gruvbox.nvim', -- colorscheme
    priority = 1000,
    config = function()
      require('pluginSets.others').gruvbox()
    end,
  },
  {
    'nvim-lualine/lualine.nvim', -- statusbar
    config = function()
      require('pluginSets.statusline')
    end,
  },
  {
    'stevearc/dressing.nvim', -- prettier code action menu
    event = 'VeryLazy',
  },
  {
    'lukas-reineke/indent-blankline.nvim', -- indent indicator
    event = 'VeryLazy',
    config = function()
      require('pluginSets.others').indent()
    end,
  },
}
