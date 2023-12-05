-- speed up startup time
vim.loader.enable()

-- Disable builtin plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  --'netrw',
  --'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Load options, mappings, and plugins
local halo_modules = {
  'mappings',
  'options',
  'pluginInit',
}

for i = 1, #halo_modules, 1 do
  pcall(require, halo_modules[i])
end
