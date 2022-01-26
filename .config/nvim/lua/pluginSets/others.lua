local M = {}

M.colorizer = function()
  local present, colorizer = pcall(require, "colorizer")
  if present then
    colorizer.setup({ "*" }, {
      RGB = true,
      RRGGBB = true,
      mode = "background",
    })
    vim.cmd "ColorizerReloadAllBuffers"
  end
end

M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")
  if present then
    luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }
    require("luasnip/loaders/from_vscode").lazy_load { paths = "~/.config/nvim/snippets" }
  end
end

M.neogit = function()
  local present, neogit = pcall(require, "neogit")
  if present then
    neogit.setup {
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      signs = {
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

M.signature = function()
  local present, lspsignature = pcall(require, "lsp_signature")
  if present then
    lspsignature.setup {
      bind = true,
      doc_lines = 2,
      floating_window = true,
      hint_enable = true,
      hint_prefix = "",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 22,
      max_width = 120,
      handler_opts = {
        border = "single",
      },
      zindex = 200,
    }
  end
end

return M
