local present, nvimtree = pcall(require, "nvim-tree")
if not present then
  return
end

vim.g.nvim_tree_add_trailing = 0
vim.g.nvim_tree_highlight_opened_files = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_quit_on_open = 0
vim.g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

vim.g.nvim_tree_show_icons = {
  folders = 1,
  files = 1,
}

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    deleted = "",
    ignored = "",
    renamed = "",
    staged = "",
    unmered = "",
    unstaged = "",
    untracked = "",
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    empty = "",
    empty_open = "",
    open = "",
    symlink = "",
    symlink_open = "",
  },
}

nvimtree.setup {
  auto_close = false,
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    width = 20,
    side = "left",
    auto_resize = true,
  },
  filters = {
    dotfiles = false,
  },
}
