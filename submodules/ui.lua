local wz = require("wezterm")
local utils = require("submodules.utils")
local M = {}
--- If tab bar is enabled by default.
local enable_tab_bar = true
--- Window decor mode.
local window_decorations = "RESIZE"
--- My current colorscheme (intended to change)
local color_scheme = "My prefered"
--- Disable fancy bar.
local use_fancy_tab_bar = false
--- Padding values.
local window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}
local my_prefered_palette = utils.my_prefered_palette
--- Tabs config
local tab_bar = {
  -- tab bar background color
  background = my_prefered_palette.background,
  -- fields for the active tab
  active_tab = {
    bg_color = my_prefered_palette.background,
    fg_color = my_prefered_palette.brights[4],
    intensity = "Bold",
  },
  -- fields for the inactive tab
  inactive_tab = {
    bg_color = my_prefered_palette.background,
    fg_color = my_prefered_palette.brights[1],
    intensity = "Bold",
  },
  inactive_tab_hover = {
    bg_color = my_prefered_palette.background,
    fg_color = my_prefered_palette.brights[6],
    intensity = "Bold",
  },
  -- fields for the new tab
  new_tab = {
    bg_color = my_prefered_palette.brights[2],
    fg_color = my_prefered_palette.brights[8],
    intensity = "Bold",
  },
  new_tab_hover = {
    bg_color = my_prefered_palette.brights[7],
    fg_color = my_prefered_palette.ansi[1],
    intensity = "Bold",
  }
}
--- Tab style reset.
local tab_style_reset = {
  bg = tab_bar.inactive_tab.bg_color,
  fg = tab_bar.inactive_tab.fg_color
}

-- tab title formating
wz.on("format-tab-title", function(tab, tabs, _, _, _, _)
  local title = utils.tab_get_title(tab)
  -- reset style
  local tab_title = {
    { Background = { Color = my_prefered_palette.brights[4] } },
    { Text = tab.tab_index == 0 and " " or "" },
    { Background = { Color = tab_style_reset.bg } },
    { Text = tab.tab_index == 0 and " " or "" },
  }
  local content = {
    { Text = string.format(" %s ", title) },
    { Background = { Color = tab_style_reset.bg } },
    { Foreground = { Color = tab_style_reset.fg } },
    { Text = (tab.tab_index + 1) < #tabs and "|" or " " }
  }
  for _, t in ipairs(content) do
    tab_title[#tab_title + 1] = t
  end
  return tab_title
end)

--- right status
wz.on("update-status", function(window, _)
  local time = wz.strftime("%H:%M")
  local day = wz.strftime("%e")
  local month = wz.strftime("%b")
  local year = wz.strftime("%Y")
  local cfg = window:effective_config()
  local palette = cfg.resolved_palette
  local fg = utils.palette_get_b_white(palette)
  local time_bg = utils.palette_get_blue(palette)
  local date_bg = utils.palette_get_cyan(palette)
  local date_foreground = utils.palette_get_background(palette)
  window:set_right_status(wz.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = fg } },
    { Background = { Color = time_bg } },
    { Text = string.format(" %s ", time) },
    { Background = { Color = date_bg } },
    { Foreground = { Color = date_foreground } },
    { Text = string.format(" %s %s, %s ", month, day, year) }
  }))
end)


M.enable_tab_bar = enable_tab_bar
M.window_decorations = window_decorations
M.color_scheme = color_scheme
M.use_fancy_tab_bar = use_fancy_tab_bar
M.window_padding = window_padding
M.color_schemes = wz.color.get_builtin_schemes() or {}
M.color_schemes[color_scheme] = my_prefered_palette
M.colors = {
  tab_bar = tab_bar
}

return M
