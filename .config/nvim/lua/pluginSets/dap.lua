local present1, dap = pcall(require, "dap")
local present2, dapui = pcall(require, "dapui")
local present3, dapinstall = pcall(require, "dap-install")
if not (present1 or present2 or present3) then
  return
end

-- loop that sets up every installed debugger
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
for _, debugger in ipairs(dbg_list) do
	dapinstall.config(debugger)
end

--dap.adapters.lldb = {
--  type = "executable",
--  command = "/usr/bin/lldb", -- adjust as needed
--  name = "lldb"
--}
--
--dap.configurations.cpp = {
--  {
--    name = "Launch",
--    type = "lldb",
--    request = "launch",
--    program = function()
--      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--    end,
--    cwd = '${workspaceFolder}',
--    stopOnEntry = false,
--    args = {},
--    runInTerminal = true,
--  },
--}
--
--dap.configurations.c = dap.configurations.cpp
--dap.configurations.rust = dap.configurations.cpp

dapui.setup()
