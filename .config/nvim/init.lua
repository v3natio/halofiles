-- speed up startup time
vim.loader.enable()

-- load options, mappings, and plugins
local halo_modules = {
  'mappings',
  'options',
  'pluginInit',
}

for i = 1, #halo_modules, 1 do
  pcall(require, halo_modules[i])
end
