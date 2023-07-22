local present, treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
  return
end

treesitter.setup {
  ensure_installed = {
    "bash",
    "bibtex",
    "cmake",
    "cpp",
    "dockerfile",
    "json",
    "latex",
    "lua",
    "markdown",
    "python",
    "regex",
    "toml",
  },
  autotag = { enable = true },
  indent = { enable = true },
  matchup = { enable = true },
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
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
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
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      lua = "-- %s",
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
