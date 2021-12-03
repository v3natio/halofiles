require("nvim-treesitter.configs").setup {
   ensure_installed = { "bash", "cmake", "cpp", "json", "latex", "lua", "ocaml", "python", "regex", "toml" },
   indent = { enable = true },
   highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = true,
      custom_captures = {
         ["punctuation.delimiter"] = "TSInclude",
         ["punctuation.special"] = "TSInclude",
         ["text.math"] = "TSFunction",
         ["text.title"] = "TSParameter",
      },
   },
   rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
   },
   textobjects = {
      swap = {
         enable = true,
         swap_next = {
            ["<Leader>;"] = "@parameter.inner",
         },
         swap_previous = {
            ["<Leader>,"] = "@parameter.inner",
         },
      },
   },
   incremental_selection = {
      enable = true,
      keymaps = {
         init_selection = "<CR>",
         scope_incremental = "<CR>",
         node_incremental = "<TAB>",
         node_decremental = "<S-TAB>",
    },
  },
}
