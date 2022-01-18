local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end

bufferline.setup {
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true,
    separator_style = "thick",
    diagnostics = "nvim_lsp",
    buffer_close_icon = "",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
      },
    },
    custom_areas = {
      right = function()
        local result = {}
        local error = vim.diagnostic.get(0, [[Error]])
        local warning = vim.diagnostic.get(0, [[Warning]])
        local info = vim.diagnostic.get(0, [[Information]])
        local hint = vim.diagnostic.get(0, [[Hint]])

        if error ~= 0 then
          result[1] = { text = "  " .. error, guifg = "#EC5241" }
        end

        if warning ~= 0 then
          result[2] = { text = "  " .. warning, guifg = "#EFB839" }
        end

        if hint ~= 0 then
          result[3] = { text = "  " .. hint, guifg = "#A3BA5E" }
        end

        if info ~= 0 then
          result[4] = { text = "  " .. info, guifg = "#7EA9A7" }
        end

        return result
      end,
    },
  },
}
