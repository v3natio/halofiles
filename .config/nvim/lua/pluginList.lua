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
      "nathom/filetype.nvim",
   }
   use {
      "lewis6991/impatient.nvim",
   }

   -- General
   use {
      "nvim-lua/plenary.nvim",
      event = "VimEnter",
   }
   use {
      "nvim-treesitter/nvim-treesitter",
      after = "nord.nvim",
      config = function()
         require "pluginSets.treesitter"
      end,
   }
   use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }
   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require "pluginSets.cmp"
      end,
   }
   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
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
      "lukas-reineke/cmp-rg",
      after = "cmp-nvim-lsp",
   }
   use {
      "ray-x/cmp-treesitter",
      after = "cmp-nvim-lsp",
   }
   use {
      "hrsh7th/cmp-path",
      after = "cmp-rg",
   }
   use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
         },
      },
      config = function()
         require "pluginSets.telescope"
      end,
   }

   -- Writing
   use {
     "vimwiki/vimwiki",
    }

   -- Development
   use {
      "skywind3000/asyncrun.vim",
      config = function()
         require("pluginSets.others").asyncrun()
      end,
   }
   use {
      "neovim/nvim-lspconfig",
      after = "nvim-lsp-installer",
      config = function()
         require "pluginSets.lspconfig"
      end,
   }
   use {
      "williamboman/nvim-lsp-installer",
      event = "InsertEnter",
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
      after = "nord.nvim",
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

   -- Eyecandy
   use {
      "shaunsingh/nord.nvim",
      after = "packer.nvim",
      config = function()
         require("nord").set()
      end,
   }
   use {
      "kyazdani42/nvim-web-devicons",
      after = "nord.nvim",
   }
   use {
      "NTBBloodbath/galaxyline.nvim",
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

   -- Miscellaneous
   use {
      "andweeb/presence.nvim",
      config = function()
         require("presence"):setup {
            main_text = "neovim",
            neovim_image_text = "Neovim",
            enable_line_number = true,
            editing_text = "Editing a file",
            file_explorer_text = "Browsing files",
            reading_text = "Reading a file",
            workspace_text = "Working on a project",
         }
      end,
   }
end)
