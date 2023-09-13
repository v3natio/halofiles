local present, packer = pcall(require, "pluginInit")
if present then
  packer = require "packer"
else
  return false
end

local use = packer.use

return packer.startup(function()
  -- Package manager
  use {
    "wbthomason/packer.nvim",
    event = "VimEnter",
  }

  -- Startup
  use {
    "lewis6991/impatient.nvim",
  }

  -- General
  use {
    "phaazon/hop.nvim",
    cmd = {
      "HopWord",
      "HopLine",
      "HopChar1",
      "HopChar2",
      "HopPattern",
    },
    as = "hop",
    config = function()
      require("hop").setup()
    end,
  }

  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "pluginSets.nvimtree"
    end,
  }

  use {
    "lervag/vimtex",
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = function()
      require "pluginSets.treesitter"
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require "pluginSets._cmp"
    end,
  }
  use {
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = function()
      require("pluginSets.others").luasnip()
    end,
  }
  use {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  }
  use {
    "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip",
  }
  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  }
  use {
    "ray-x/cmp-treesitter",
    after = "cmp-nvim-lsp",
  }
  use {
    "hrsh7th/cmp-path",
    after = "cmp-treesitter",
  }

  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-lua/plenary.nvim",
        run = "make",
      },
    },
    config = function()
      require "pluginSets.telescope"
    end,
  }

  -- Writing
  use {
    "Pocco81/TrueZen.nvim",
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZFocus",
    },
    config = function()
      require "pluginSets.zenmode"
    end,
  }

  -- Development
  use {
    "skywind3000/asyncrun.vim",
    event = "InsertEnter",
    config = function()
      vim.g.asyncrun_open = 6
      vim.g.asyncrun_bell = 1
      vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "_darcs" }
    end,
  }

  use {
    "neovim/nvim-lspconfig",
    after = "nvim-lsp-installer",
  }
  use {
    "williamboman/nvim-lsp-installer",
    opt = true,
    setup = function()
      require("options").packer_lazy_load "nvim-lsp-installer"
      -- reload the file so lsp starts for it
      vim.defer_fn(function ()
        vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
      end, 0)
    end,
    config = function()
      require "pluginSets.lspconfig"
    end,
  }
  use {
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("pluginSets.others").signature()
    end,
  }
  use {
    "lewis6991/gitsigns.nvim",
    after = "gruvbox-flat.nvim",
    config = function()
      require "pluginSets.gitsigns"
    end,
  }
  use {
    "TimUntersberger/neogit",
    cmd = {
      "Neogit",
      "Neogit commit",
    },
    config = function()
      require("pluginSets.others").neogit()
    end,
  }
  use {
    "sindrets/diffview.nvim",
    after = "neogit",
  }

  use {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("pluginSets.others").colorizer()
    end,
  }

  -- Eyecandy
  use {
    "eddyekofo94/gruvbox-flat.nvim",
    after = "packer.nvim",
    config = function()
      vim.g.gruvbox_transparent = true
      vim.cmd "colorscheme gruvbox-flat"
    end,
  }
  use {
    "nvim-lualine/lualine.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "pluginSets.statusline"
    end,
  }
  use {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "pluginSets.bufferline"
    end,
  }
  use {
    "kyazdani42/nvim-web-devicons",
    after = "gruvbox-flat.nvim",
  }
end)
