local M = {}

M.luasnip = function()
   local present, luasnip = pcall(require, "luasnip")
   if not present then
      return
   end

   luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
   }
   require("luasnip/loaders/from_vscode").load()
   require("luasnip").filetype_extend("python", { "django" })
end

M.signature = function()
   local present, lspsignature = pcall(require, "lsp_signature")
   if present then
      lspsignature.setup {
         bind = true,
         doc_lines = 2,
         floating_window = true,
         fix_pos = true,
         hint_enable = true,
         hint_prefix = " ",
         hint_scheme = "String",
         hi_parameter = "Search",
         max_height = 22,
         max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
         handler_opts = {
            border = "single", -- double, single, shadow, none
         },
         zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
         padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
      }
   end
end

M.neogit = function()
   local present, neogit = pcall(require, "neogit")
   if present then
      neogit.setup {
         disable_signs = false,
         disable_context_highlighting = false,
         disable_commit_confirmation = false,
         -- customize displayed signs
         signs = {
            -- { CLOSED, OPENED }
            section = { "", "" },
            item = { "", "" },
            hunk = { "", "" },
         },
         integrations = {
            diffview = true,
         },
      }
   end
end

M.asyncrun = function()
   vim.g.asyncrun_open = 6
   vim.g.asyncrun_bell = 1
   vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "_darcs" }
end

--M.vimwiki = function()
--  vim.g['vimwiki_ext2syntax'] = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
--  vim.g['vimwiki_list'] = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
--end

return M
