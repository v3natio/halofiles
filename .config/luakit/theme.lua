--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "16px FiraCode Nerd Font"
theme.fg   = "#ebdbb2"
theme.bg   = "#282828"

-- Genaral colours
theme.success_fg = "#b8bb26"
theme.loaded_fg  = "#83a598"
theme.error_fg = "#ebdbb2"
theme.error_bg = "#fb4934"

-- Warning colours
theme.warning_fg = "#ebdbb2"
theme.warning_bg = "#fabd2f"

-- Notification colours
theme.notif_fg = "#ebdbb2"
theme.notif_bg = "#928374"

-- Menu colours
theme.menu_fg                   = "#ebdbb2"
theme.menu_bg                   = "#3c3836"
theme.menu_selected_fg          = "#b8bb26"
theme.menu_selected_bg          = "#928374"
theme.menu_title_bg             = "#ebdbb2"
theme.menu_primary_title_fg     = "#ebdbb2"
theme.menu_secondary_title_fg   = "#ebdbb2"

theme.menu_disabled_fg = "#928374"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg = theme.menu_fg
theme.menu_enabled_bg = theme.menu_bg
theme.menu_active_fg = "#ebdbb2"
theme.menu_active_bg = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg      = "#ebdbb2"
theme.proxy_active_menu_bg      = "#3c3836"
theme.proxy_inactive_menu_fg    = "#ebdbb2"
theme.proxy_inactive_menu_bg    = "#928374"

-- Statusbar specific
theme.sbar_fg         = "#ebdbb2"
theme.sbar_bg         = "#3c3836"

-- Downloadbar specific
theme.dbar_fg         = "#ebdbb2"
theme.dbar_bg         = "#3c3836"
theme.dbar_error_fg   = "#fb4934"

-- Input bar specific
theme.ibar_fg           = "#ebdbb2"
theme.ibar_bg           = "#3c3836"

-- Tab label
theme.tab_fg            = "#ebdbb2"
theme.tab_bg            = "#3c3836"
theme.tab_hover_bg      = "#928374"
theme.tab_ntheme        = "#928374"
theme.selected_fg       = "#b8bb26"
theme.selected_bg       = "#928374"
theme.selected_ntheme   = "#928374"
theme.loading_fg        = "#ebdbb2"
theme.loading_bg        = "#8ec07c"

theme.selected_private_tab_bg = "#3c3836"
theme.private_tab_bg    = "#d3869b"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#b8bb26"
theme.notrust_fg        = "#fb4934"

-- Follow mode hints
theme.hint_font = "14px FiraCode Nerd Font"
theme.hint_fg = "#ebdbb2"
theme.hint_bg = "#3c3836"
theme.hint_border = "1px dashed #3c3836"
theme.hint_opacity = "0.3"
theme.hint_overlay_bg = "rgba(60,56,54,0.3)"
theme.hint_overlay_border = "1px dotted #3c3836"
theme.hint_overlay_selected_bg = "rgba(184,187,38,0.3)"
theme.hint_overlay_selected_border = theme.hint_overlay_border

-- General colour pairings
theme.ok = { fg = "#ebdbb2", bg = "#3c3836" }
theme.warn = { fg = "#ebdbb2", bg = "#fabd2f" }
theme.error = { fg = "#ebdbb2", bg = "#fb4934" }

-- Gopher page style (override defaults)
theme.gopher_light = { bg = "#fbf1c7", fg = "#3c3836", link = "#8f3f71" }
theme.gopher_dark  = { bg = "#282828", fg = "#ebdbb2", link = "#d3869b" }

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
