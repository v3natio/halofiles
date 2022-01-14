-- Load impatient first
local present, impatient = pcall(require, "impatient")

-- Disable builtin plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- since we lazy load packer.nvim, we need to load it when we run packer-related commands
vim.cmd "silent! command PackerCompile lua require 'pluginList' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'pluginList' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'pluginList' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'pluginList' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'pluginList' require('packer').update()"

-- Load options, mappings, and plugins
local halo_modules = {
  "options",
  "mappings",
  "packer_compiled",
}

for i = 1, #halo_modules, 1 do
  pcall(require, halo_modules[i])
end
